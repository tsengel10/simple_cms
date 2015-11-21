class PagesController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_subject
  before_action :count_pages

  layout "admin"

  #GET pages/index
  def index
    @pages = @subject.pages.sorted
  end

  #GET subjects/show?id=2
  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => "Default"})
    @subjects = Subject.order('position ASC')
    @page_count += 1
  end

  def create
    @page = Page.new(permit_page_params)
    if @page.save
      flash[:notice] = "Page created successfully!"
      redirect_to(:action => 'index', :subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')
      @page_count += 1
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(permit_page_params)
      flash[:notice] = "Page updated successfully!"
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')
      render('edit')
    end
  end
  

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully!"
    redirect_to(:action => 'index', :subject_id => @subject.id)
  end

  private
    def permit_page_params
      #Requiring page because in HTML we grouped inputs with page
      params.require(:page).permit(:name, :position, :visible, :permalink, :subject_id)
    end

    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end

    def count_pages
      @page_count = Page.where("subject_id = ?", @subject.id).count
    end

end

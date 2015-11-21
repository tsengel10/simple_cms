class SectionsController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_page
  before_action :count_sections
  
  layout "admin"

  #GET pages/index
  def index
    @sections = @page.sections.sorted
  end

  #GET subjects/show?id=2
  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => @page.id, :name => "Default"})
    @pages = Page.order('position ASC')
    @section_count += 1
  end

  def create
    @section = Section.new(permit_section_params)
    if @section.save
      flash[:notice] = "Section created successfully!"
      @section_count += 1
      redirect_to(:action => 'index', :page_id => @page.id)
    else
      render('new')
    end

  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.all
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(permit_section_params)
      flash[:notice] = "Section updated successfully!"
      redirect_to(:action => 'show', :id => @section.id, :page_id => @section.page_id)
    else
      render('edit')
    end
  end
  

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' destroyed successfully!"
    redirect_to(:action => 'index',:page_id => @page.id)
  end

  private
    def permit_section_params
      #Requiring page because in HTML we grouped inputs with page
      params.require(:section).permit(:name, :page_id, :position, :visible, :content_type, :content)
    end

    def find_page
      if params[:page_id]
        @page = Page.find(params[:page_id])
      end
    end

    def count_sections
      @section_count = Section.where("page_id = ?", @page.id).count
    end

end

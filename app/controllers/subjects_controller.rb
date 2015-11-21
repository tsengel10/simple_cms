class SubjectsController < ApplicationController
  before_action :confirm_logged_in
  before_action :count_subjects

  layout "admin"

  #GET subjects/index
  def index
    @subjects = Subject.sorted
  end

  #GET subjects/show?id=2
  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
    @subject_count += 1
  end

  def create
    @subject = Subject.new(permit_subject_params)
    if @subject.save
      flash[:notice] = "Subject created successfully!"
      redirect_to(:action => 'index')

    else
      @subject_count += 1
      render('new')
    end

  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(permit_subject_params)
      flash[:notice] = "Subject updated successfully!"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      render('edit')
    end
  end
  

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subj = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subj.name}' destroyed successfully!"
    redirect_to(:action => 'index')
  end

  private
    def permit_subject_params
      #Requiring subject because in HTML we grouped inputs with subject
      params.require(:subject).permit(:name, :position, :visible, :created_at)
    end

    def count_subjects
      @subject_count = Subject.count
    end
end

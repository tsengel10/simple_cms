class PublicController < ApplicationController
  before_action :setup_navigation
  

  layout 'public'

  def index

  	# intro text goes here
  end

  def show
  	@page = Page.where(:permalink => params[:permalink], :visible => true).first
  	if @page.nil?
  		redirect_to(:action => 'index')
  	else
  		#display page with show.html.erb

  	end

  end

  private
  	def setup_navigation
  		@subjects = Subject.visible.sorted
  		
  	end
end

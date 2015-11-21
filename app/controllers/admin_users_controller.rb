class AdminUsersController < ApplicationController
  before_action :confirm_logged_in
  before_action :count_admin_users

  layout "admin"

  #GET subjects/index
  def index
    @admin_users = AdminUser.sorted
    @admin_count += 1
  end

  def new
    @admin_user = AdminUser.new
    @admin_count += 1
  end

  def create
    @admin_user = AdminUser.new(permit_adminuser_params)
    if @admin_user.save
      flash[:notice] = "Admin user created successfully!"
      redirect_to(:action => 'index')
    else
      @admin_count += 1
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(permit_adminuser_params)
      flash[:notice] = "Admin user updated successfully!"
      redirect_to(:action => 'index')
    else
      render('edit')
      
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    admin_user = AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin user '#{admin_user.name}' destroyed successfully!"
    redirect_to(:action => 'index')
  end

  private
    def permit_adminuser_params
      #Requiring admin user because in HTML we grouped inputs with admin_user
      params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
    end

    def count_admin_users
      @admin_count = AdminUser.count
    end
end

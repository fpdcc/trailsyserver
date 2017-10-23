class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :approve, :destroy]
  before_action :authenticate_user!
  #before_action :check_admin
  before_action :count_admins

  def new
    @user = User.new
    authorize @user
  end

  def index
    authorize User
    if params[:approved] == "false"
      @users = User.where(approved: false).order(:email)
    else
      @users = User.all.order(:email)
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    count_admins
    if @admin_count == 1 && @user.admin? && !params[:admin]
      render action: 'edit'
      return
    end
    if @user.update(user_params)
      redirect_to action: "index" , notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @user
    if @user.destroy
      redirect_to users_path, notice: "User was successfully deleted."
    else
      redirect_to :back, alert: "An error occurred when deleting the user."
    end
  end

  def create
    authorize User
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new
    end
  end
  
  def approve
    authorize @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:approved, :role, :organization_id, :admin, :password, :password_confirmation, :email)
    end

    def check_admin
      unless current_user.admin?
        flash[:notice] = "Admin account required to access users page."
        redirect_to trails_path
      end
    end

    def count_admins
      @admin_count = User.where("role = ?", User.roles[:admin]).count
    end
end

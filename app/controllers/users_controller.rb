class UsersController < ApplicationController
  #before_filter :super_user,      :only => :destroy
  before_filter :admin_user,      :only => [:new, :create]
  before_filter :candidate_user,  :only => :show
  before_filter :correct_user_or_admin,    :only => [:edit, :update]
  
  def index
    @title = "Candidates"
    @admins = User.where("user_type < 2") unless !current_user
    @users = User.find_all_by_user_type("2")
  end
  
  def show
    @user = User.find_by_id(params[:id])
    raise ActiveRecord::RecordNotFound if @user.nil?
    if !current_user && @user.user_type < 2 
      flash[:notice] = "You must be logged in to view administrators"
      redirect_to root_url
    else
      @title = @user.name
      if current_user && (current_user == @user || current_user.user_type < 2)
        @edit = true
      end
    end
  end
  
  def new
    @title = "Register new user"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "New user created."
      redirect_to user_path(@user)
    else
      @title = "Register new user"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Editing account: " + @user.email
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated profile."
      redirect_to user_path(@user)
    else
      @title = "Editing account: " + @user.email
      render :action => 'edit'
    end
  end
  
  private
    
    def admin_user
      if !current_user || current_user.user_type > 1
        flash[:notice] = "You are not allowed to access this resource."
        redirect_to(root_path)
      end
    end
    
    def candidate_user(user = User.find(params[:id]))
      redirect_to(root_path) unless user.user_type
    end
    
    def correct_user_or_admin
      @user = User.find(params[:id])
      if !current_user || (current_user.user_type > 1 && current_user != @user)
        flash[:notice] = "You are not allowed to access this resource."
        redirect_to root_path and return
      end
    end
end

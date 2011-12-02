class UserSessionsController < ApplicationController
  def new
    @title = "Sign in"
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Successfully logged in."
      redirect_to root_url
    else
      flash[:error] = "Login error: invalid email/password combination."
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:success] = "Successfully logged out."
    redirect_to root_url
  end
end
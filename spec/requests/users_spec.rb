require 'spec_helper'

describe "Users" do
  describe "sign in" do
    describe "failure" do
      visit signin_path
      fill_in :email, :with => ""
      fill_in :password, :with => ""
      click_button
      response.should render_template('user_sessions/new')
      response.should have_selector('div.flash.error')
    end
    
    describe "success" do
      user = Factory(:user)
      visit signin_path
      fill_in :email,   :with => user.email
      fill_in :password,  :with => user.password
      click_button
      response.should render_template('pages/home')
      response.should have_selector('div.flash.success')
    end
  end
  
  describe "signup (by admins)" do
    before(:each) do
      integration_sign_in(Factory(:user, :user_type => 1))
    end
    
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit new_user_path
          fill_in "Name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Password Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div", :id => "error_explanation")
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit new_user_path
          fill_in "Name", :with => "Test"
          fill_in "Email", :with => "test@example.com"
          fill_in "Password", :with => "foobar"
          fill_in "Password Confirmation", :with => "foobar"
          click_button
          response.should render_template('users/show')
          response.should have_selector('div.flash.success')
        end.should change(User, :count).by(1)
      end
    end
  end
end

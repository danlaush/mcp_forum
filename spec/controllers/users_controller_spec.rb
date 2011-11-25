require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the correct title" do
      get :new
      response.should have_selector("title", :content => @base_title + " : Sign in")
    end
  end

end

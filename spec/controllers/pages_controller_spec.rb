require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "Candidate Forum"
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get :home
      response.should be_success
    end
    
    it "should have the correct title" do
      get :home
      response.should have_selector("title", :content => @base_title)
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get :about
      response.should be_success
    end
    
    it "should have the correct title" do
      get :about
      response.should have_selector("title", :content => "About")
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get :help
      response.should be_success
    end
    
    it "should have the correct title" do
      get :help
      response.should have_selector("title", :content => "Help")
    end
  end
end

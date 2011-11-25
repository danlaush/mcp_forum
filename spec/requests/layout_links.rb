require 'spec_helper'

describe "Layout Links" do
  it "should have a home page at /" do
    get '/'
    response.should have_selector("title", :content => "Forum")
  end
  
  it "should have an about page at /about" do
    get '/'
    response.should have_selector("title", :content => "About")
  end
  
  it "should have a help page at /help" do
    get '/'
    response.should have_selector("title", :content => "Help")
  end
  
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end
end

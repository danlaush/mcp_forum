require 'spec_helper'

describe QuestionsController do
  
  before(:each) do
    @q1 = Factory(:question)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => '1'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      get :create
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit
      response.should be_success
    end
  end

  describe "POST 'update'" do
    it "should be successful" do
      get :update
      response.should be_success
    end
  end

  describe "POST 'destroy'" do
    it "should be successful" do
      get :destroy
      response.should be_success
    end
  end

end

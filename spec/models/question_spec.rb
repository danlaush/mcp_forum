# == Schema Information
#
# Table name: questions
#
#  id         :integer         not null, primary key
#  content    :text
#  name       :string(255)
#  entity     :string(255)
#  email      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Question do
  describe "for non-signed-in users" do
    before(:each) do
      @attr = {
        :name => "Example User",
        :entity => "@US - Seattle",
        :email => "user@example.com",
        :content => "This is a new question for all the candidates: Why is AIESEC US the best?"
      }
    end
    
    it "should create a new instance given valid attributes" do
      Question.create!(@attr)
    end
    
    it "should accept names that are zero chars" do
      short_name = ""
      short_name_user = Question.new(@attr.merge(:name => short_name))
      short_name_user.should be_valid
    end
    
    it "should reject names that are too long" do
      long_name = "a" * 31
      long_name_user = Question.new(@attr.merge(:name => long_name))
      long_name_user.should_not be_valid
    end
    
    it "should accept entities that are zero chars" do
      short_entity = ""
      short_entity_user = Question.new(@attr.merge(:entity => short_entity))
      short_entity_user.should be_valid
    end
    
    it "should reject entities that are too long" do
      long_entity = "a" * 31
      long_entity_user = Question.new(@attr.merge(:entity => long_entity))
      long_entity_user.should_not be_valid
    end
    
    it "should accept emails that are zero chars" do
      short_email = ""
      short_email_user = Question.new(@attr.merge(:email => short_email))
      short_email_user.should be_valid
    end
  
    it "should reject emails that are too long" do
      long_email = "a" * 51 + "@example.com"
      long_email_user = Question.new(@attr.merge(:email => long_email))
      long_email_user.should_not be_valid
    end
    
    it "should accept valid emails" do
      emails = ["niceandsimple@example.com", "a.little.unusual@example.com", "a.little.more_unusual@dept.example.com", "VERY.__very-UnUsUaL@strange.ex-ample.com"]
      emails.each do |email|
        valid_email_user = Question.new(@attr.merge(:email => email))
        valid_email_user.should be_valid
      end
    end
    
    it "should reject invalid emails" do
      emails = ["Abc.example.com","A@b@c@example.com","\"(),:;<>[\\]@example.com","just\"not\"right@example.com"]
      emails.each do |email|
        invalid_email_user = Question.new(@attr.merge(:email => email))
        invalid_email_user.should_not be_valid
      end
    end
  
    it "should reject questions that are too short" do
      no_content = Question.new(@attr.merge(:content => ""))
      no_content.should_not be_valid
    end
  end
  
  describe "for signed-in users" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in @user
      @attr = {
        :content => "This is a new question for all the users from your possible MCPs2: Why is AIESEC US the best?"
      }
    end
    
    it "should create the question correctly" do
      @question = @user.questions.create!(@attr)
    end
    
    describe "attributes" do
      before(:each) do
        @question = @user.questions.create!(@attr)
      end
    
      it "should have a content attribute" do
        @question.should respond_to(:content)
      end
      
      it "should have a user_id attribute" do
        @question.should respond_to(:user_id)
      end
      
      it "should have the right associated user" do
        @question.user_id.should == @user.id
      end
    end
  end
end

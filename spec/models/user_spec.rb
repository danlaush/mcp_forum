# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  crypted_password   :string(255)
#  password_salt      :string(255)
#  persistence_token  :string(255)
#  color              :string(255)     default("bbbbbb")
#  created_at         :datetime
#  updated_at         :datetime
#  user_type          :integer         default(2)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  about              :text
#

require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :color => "#ff0000",
      :user_type => "2"
    }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should reject names that are too short" do
    no_name = User.new(@attr.merge(:name => ""))
    no_name.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 31
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid names" do
    names = ["Dan Laush", "DANLAUSH", "danlaush123", "dan_laush", "-xXDan_LaushXx-"]
    names.each do |name|
      valid_name_user = User.new(@attr.merge(:name => name))
      valid_name_user.should be_valid
    end
  end
  
  it "should reject invalid usernames" do
    names = ["%danlaush%","; --mysql DROP * from BobbyTables"]
    names.each do |name|
      invalid_name_user = User.new(@attr.merge(:name => name))
      invalid_name_user.should_not be_valid
    end
  end
end

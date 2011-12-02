# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  email             :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)
#  color             :string(255)     default("#bbbbbb")
#  created_at        :datetime
#  updated_at        :datetime
#  user_type         :integer         default(2)
#

class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :name, :email, :password, :password_confirmation, :color, :photo, :about
  has_attached_file :photo, :styles => { :profile => "200x200>" },
                    :url => "/images/users/:id/:style.:extension",  
                    :path => ":rails_root/public/images/users/:id/:style.:extension",
                    :default_url => "/images/users/default.jpg"
  
  validates   :name,    
              :presence   => true,
              :length     => { :within => 1..30 },
              :format     => { :with => /^[\w\. -]{1,30}$/i },
end

# == Schema Information
#
# Table name: questions
#
#	id          :integer				 not null, primary key
#	content     :text
#	name        :string(255)
#	entity      :string(255)
#	email       :string(255)
#	user_id     :integer
#	created_at  :datetime
#	updated_at  :datetime
#

class Question < ActiveRecord::Base
	
	EMAIL_REGEX = /^[\w.+-]+@[\w.+-]+\.[A-Z]{2,4}$/i
	
	validates	 :name,
							:length    => { :maximum => 30 },
							:allow_blank => true
	
	validates	 :entity,
              :length    => { :maximum => 30 },
              :allow_blank => true
							
	validates	 :email,
              :length    => { :maximum => 50 },
							:format    => { :with => EMAIL_REGEX }, 
              :allow_blank => true

  validates  :content,
              :presence  => true
              
end
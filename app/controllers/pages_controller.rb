class PagesController < ApplicationController
	def home
	  @question = Question.new
	  @questions = Question.all
	end

	def about
		@title = "About"
	end
	
	def help
	  @title = "Help"
	end

end

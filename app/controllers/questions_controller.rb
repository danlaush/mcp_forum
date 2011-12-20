class QuestionsController < ApplicationController
  respond_to :html, :js
  
  def index
    @title = "Questions"
    @questions = Question.all
  end

  def show
    @title = "Question"
    @question = Question.find(params[:id])
  end

  def new
    @title = "New Question"
    @question = Question.new
  end

  def create
    if current_user
      @question = current_user.questions.build(params[:question])
    else
      @question = Question.new(params[:question])
    end
    flash[:success] = "Question posted successfully." unless @question.save
    respond_with root_url
=begin
    if 
      flash[:success] = "Question created"
      redirect_to(root_path)
    else
      render 'new'
    end
=end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show edit update destroy]
  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    @answers = Answer.order created_at: :desc
  end

  def new
    @question = Question.new
  end
  def create
    @question = Question.new question_params
    if @question.save
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end
  def update
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end
end

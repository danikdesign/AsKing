class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show edit update destroy]
  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
    @questions = @questions.decorate
  end

  def show
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @answers = @answers.decorate
  end

  def new
    @question = Question.new
  end
  def create
    @question = current_user.questions.build question_params
    if @question.save
      flash[:success] = "Thank's for your question!"
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end
  def update
    if @question.update question_params
      flash[:success] = "Your question has been updated"
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
    @question = @question.decorate
  end
end

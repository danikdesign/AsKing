class AnswersController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_question!
  before_action :set_answer!, only: %i[edit update destroy]

  def new
    @answer = @question.answers.create answer_params
    @answer = @answer.decorate
  end
  def create
    @answer = @question.answers.create answer_params
    @answer = @answer.decorate

    if @answer.save
      flash[:success] = "Answer created!"
      redirect_to question_path(@question)
    else
      @pagy, @answers = pagy @question.answers.order(created_at: :desc)
      @answers.decorate
      render 'questions/show', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @answer.update answer_params
      flash[:success] = "Your answer updated!"
      redirect_to question_path(@question, anchor: dom_id(@answer))
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @answer.destroy
    flash[:success] = "Answer deleted!"

    redirect_to question_path(@question)
  end



  private
  def set_question!
    @question = Question.find params[:question_id]
    @question = @question.decorate
  end

  def set_answer!
    @answer = @question.answers.find params[:id]
    @answer = @answer.decorate
  end
  def answer_params
    params.require(:answer).permit(:body)
  end
end


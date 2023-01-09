class AnswersController < ApplicationController
  include QuestionsAnswers
  include ActionView::RecordIdentifier
  before_action :set_question!
  before_action :set_answer!, only: %i[edit update destroy]
  before_action :authorize_answer!
  after_action :verify_authorized

  def create
    @answer = @question.answers.create answer_create_params
    @answer = @answer.decorate

    if @answer.save
      flash[:success] = "Answer created!"
      redirect_to question_path(@question)
    else
      load_question_answers do_render: true
    end
  end

  def edit
  end

  def update
    if @answer.update answer_update_params
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
  def answer_create_params
    params.require(:answer).permit(:body).merge(user: current_user)
  end

  def answer_update_params
    params.require(:answer).permit(:body)
  end

  def authorize_answer!
    authorize(@answer || Answer)
  end
end


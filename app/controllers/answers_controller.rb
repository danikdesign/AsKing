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
      respond_to do |format|
        format.html do
          flash[:success] = "Answer created!"
          redirect_to question_path(@question)
        end

        format.turbo_stream do
          @answer = @answer.decorate
          flash.now[:success] = "Answer created!"
        end
      end
    else
      load_question_answers do_render: true
    end
  end

  def edit
  end

  def update
    if @answer.update answer_update_params
      respond_to do |format|
        format.html do
          flash[:success] = "Your answer was updated!"
          redirect_to question_path(@question, anchor: dom_id(@answer))
        end

        format.turbo_stream do
          @answer = @answer.decorate
          flash.now[:success] = "Your answer was updated!"
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html do
        flash[:success] = "Answer was deleted!"
        redirect_to question_path(@question)
      end

      format.turbo_stream { flash.now[:success] = "Answer was deleted!" }
    end
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


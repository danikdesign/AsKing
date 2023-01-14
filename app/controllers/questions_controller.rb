class QuestionsController < ApplicationController
  include QuestionsAnswers
  before_action :set_question!, only: %i[show edit update destroy]
  before_action :fetch_tags, only: %i[new edit]
  before_action :require_authentication, except: %i[index show]
  before_action :authorize_question!
  after_action :verify_authorized
  def index
    @pagy, @questions = pagy Question.all_by_tags(params[:tag_ids])
    @questions = @questions.decorate
    @tags = Tag.all
  end

  def show
    load_question_answers
  end

  def new
    @question = Question.new
  end
  def create
    @question = current_user.questions.build question_params
    if @question.save
      respond_to do |format|
        format.html do
          flash[:success] = "Thank's for your question!"
          redirect_to questions_path
        end

        format.turbo_stream do
          @question = @question.decorate
          flash.now[:success] = "Thank's for your question!"
        end
      end

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end
  def update
    if @question.update question_params
      respond_to do |format|
        format.html do
          flash[:success] = "Your question has been updated"
          redirect_to questions_path
        end

        format.turbo_stream do
          @question = @question.decorate
          flash.now[:success] = "Your question has been updated"
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html do
        flash[:success] = "Your question was deleted"
        redirect_to questions_path, status: :see_other
      end

      format.turbo_stream do
        flash.now[:success] = "Your question was deleted"
      end
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, tag_ids: [])
  end

  def set_question!
    @question = Question.find params[:id]
    @question = @question.decorate
  end

  def fetch_tags
    @tags = Tag.all
  end

  def authorize_question!
    authorize(@question || Question)
  end
end

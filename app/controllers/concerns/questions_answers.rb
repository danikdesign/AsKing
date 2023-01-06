module QuestionsAnswers
  extend ActiveSupport::Concern

  included do
    def load_question_answers(do_render: false)
      @question = @question.decorate
      @answer ||= @question.answers.build
      @pagy, @answers = pagy @question.answers.includes(:user).order(created_at: :desc)
      @answers = @answers.decorate
      if do_render
        render 'questions/show', status: :unprocessable_entity
      end
    end
  end
end
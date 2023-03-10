class Answer < ApplicationRecord
  include Commentable
  include Authorship

  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: { minimum: 5 }

end

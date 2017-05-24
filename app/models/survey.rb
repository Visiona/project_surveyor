class Survey < ApplicationRecord
  has_many :range_questions
  has_many :multi_questions
end

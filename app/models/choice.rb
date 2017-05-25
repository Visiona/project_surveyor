class Choice < ApplicationRecord
  belongs_to :multi_q
  has_many :multi_answers
end

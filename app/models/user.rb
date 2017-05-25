class User < ApplicationRecord
  has_many :range_answers
  has_many :multi_answers
end

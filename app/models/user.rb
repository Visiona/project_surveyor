class User < ApplicationRecord
  has_many :range_answers
  has_many :multi_answers
  has_many :multi_qs, :through => :multi_answers
  # belongs_to :survey, :through => :multi_qs
end

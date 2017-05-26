class Survey < ApplicationRecord
  has_many :range_q_and_cs
  has_many :multi_qs
  has_many :multi_answers, :through => :multi_qs
  has_many :users, :through => :multi_answers
end

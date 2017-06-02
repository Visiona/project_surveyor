class Survey < ApplicationRecord
  has_many :range_q_and_cs, :dependent => :destroy
  has_many :multi_qs, :dependent => :destroy
  has_many :multi_answers, :through => :multi_qs, :dependent => :destroy
  has_many :users, :through => :multi_answers
end

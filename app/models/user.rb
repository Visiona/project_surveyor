class User < ApplicationRecord
  has_many :range_answers
  has_many :multi_answers
  has_many :multi_qs, :through => :multi_answers
  # belongs_to :survey, :through => :multi_qs
  accepts_nested_attributes_for :multi_answers,
                                :reject_if => :all_blank, 
                                :allow_destroy => :true
end

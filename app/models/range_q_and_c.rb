class RangeQAndC < ApplicationRecord
  belongs_to :survey
  has_many :range_answers
end

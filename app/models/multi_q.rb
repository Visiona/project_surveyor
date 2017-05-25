class MultiQ < ApplicationRecord
  belongs_to :survey
  has_many :multi_answers
  has_many :choices
end

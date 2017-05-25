class Survey < ApplicationRecord
  has_many :range_q_and_cs
  has_many :multi_qs
end

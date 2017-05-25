class MultiAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :multi_q
  belongs_to :choice
end

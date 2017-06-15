class MultiAnswer < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :multi_q
  belongs_to :choice, optional: true
end

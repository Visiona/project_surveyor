class MultiAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :mutli_q
  belongs_to :choice
end

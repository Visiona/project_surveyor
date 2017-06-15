class User < ApplicationRecord
  has_many :range_answers
  has_many :multi_answers
  # has_many :choices, :through => :multi_answer
  has_many :multi_qs, :through => :multi_answers
  # belongs_to :survey, :through => :multi_qs

  accepts_nested_attributes_for :multi_answers,
                                :reject_if => :all_blank, 
                                :allow_destroy => :true

  validate :required_question_was_answered

  def required_question_was_answered
    multi_qs.each do |q| 
      if q.required 
        if find_relevant_answers(q).empty?
          errors.add(:required_q, "This Question is required")
        end
      end
    end
  end
 
 def find_relevant_answers(question)
  multi_answers.where(:multi_q_id => question.id)
 end

end

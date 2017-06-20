class Survey < ApplicationRecord
  has_many :range_q_and_cs, :dependent => :destroy
  has_many :multi_qs, :dependent => :destroy
  has_many :multi_answers, :through => :multi_qs, :dependent => :destroy
  has_many :users, -> { distinct }, :through => :multi_answers


  # def count_choice_picks(choice_id)
    
  # end

  def has_no_multi_questions_with_text?
    all_questions = self.multi_qs
    if all_questions.empty?
      return true
    elsif all_questions.all?(&:has_no_question?)
      return true
    else
      return false
    end
  end

  def has_questions?
    !has_no_questions?
  end

  def has_no_questions?
    has_no_multi_questions_with_text?
  end

  def has_question?
    self.question
  end

  def all_multi_qs_with_question
    self.multi_qs.where.not(question: nil)
  end


end

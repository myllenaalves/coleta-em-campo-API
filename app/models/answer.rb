class Answer < ActiveRecord::Base
  validates :content, :question_id, :formulary_id, presence: true
  belongs_to :question
  belongs_to :formulary
  belongs_to :visit
  validate :question_id_exists?
  validate :formulary_id_exists?
  def question_id_exists?
    if !Question.exists?(question_id)
      errors.add(:question_id, "Pergunta não existe")
    end
  end

  def formulary_id_exists?
    if !Formulary.exists?(formulary_id)
      errors.add(:formulary_id, "Formulário não existe")
    end
  end
end

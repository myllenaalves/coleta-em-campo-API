class Answer < ActiveRecord::Base
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

class Question < ActiveRecord::Base
  has_one_attached :image
  has_one :answer
  validates_uniqueness_of :name, scope: :formulary_id
  validate :formulary_id_exists?

  def formulary_id_exists?
    if !Formulary.exists?(formulary_id)
      errors.add(:formulary_id, "Formulário não existe")
    end
  end
end

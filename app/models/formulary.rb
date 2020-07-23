class Formulary < ActiveRecord::Base
  validates :name, uniqueness: true
  validates_uniqueness_of :questions
  has_many :questions, -> { distinct:true }
  has_many :answers
end

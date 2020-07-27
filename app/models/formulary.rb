class Formulary < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :questions
  has_many :answers
end

class Formulary < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  has_many :questions
  has_many :answers
end

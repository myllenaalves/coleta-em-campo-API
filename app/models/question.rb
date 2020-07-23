class Question < ActiveRecord::Base
  has_one_attached :image
  has_one :answer
  validates_uniqueness_of :name, scope: :formulary_id
end

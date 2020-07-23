class QuestionSerializer < ActiveModel::Serializer
  attributes :name, :formulary_id, :question_type, :image

  def image
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
  
end

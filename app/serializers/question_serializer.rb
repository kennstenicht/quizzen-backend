class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :label, :source, :date
  
  has_many :answers
end

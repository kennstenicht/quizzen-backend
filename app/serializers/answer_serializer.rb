class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :label, :value, :information
  
  belongs_to :question
end

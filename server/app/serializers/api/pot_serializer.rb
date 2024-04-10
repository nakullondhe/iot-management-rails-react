class Api::PotSerializer < ActiveModel::Serializer
  attributes :id, :title, :context
end

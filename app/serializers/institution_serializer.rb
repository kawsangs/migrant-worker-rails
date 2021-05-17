class InstitutionSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :contacts
end

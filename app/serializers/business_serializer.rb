# Business Serializer
class BusinessSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name, :address, :address2, :city, :state, :zip
  attributes :country, :phone, :website, :created_at
end

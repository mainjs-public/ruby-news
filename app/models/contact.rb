class Contact
  include Mongoid::Document
  field :firstName, type: String
  field :lastName, type: String
  field :email, type: String
  field :phone, type: String
  field :message, type: String
  field :created, type: DateTime, default: Time.now
  field :read, type: Boolean, default: false
end

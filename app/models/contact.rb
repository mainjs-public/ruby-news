class Contact
  include Mongoid::Document
  field :firstName, type: String
  field :lastName, type: String
  field :email, type: String
  field :phone, type: String
  field :message, type: String
  field :read, type: Boolean, default: false
end

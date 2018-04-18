class Folder
  include Mongoid::Document

  has_many :images

  field :name, type: String
  field :path, type: String
  field :created, type: DateTime, default: Time.now
end

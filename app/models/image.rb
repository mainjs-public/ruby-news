class Image
  include Mongoid::Document

  belongs_to :folder

  field :folder_id, type: String

  field :name, type: String
  field :path, type: String
  field :created, type: DateTime, default: Time.now
end

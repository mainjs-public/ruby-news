class Blog
  include Mongoid::Document

  belongs_to :category, validate: true

  field :category_id, type: String
  field :slug, type: String
  field :name, type: String
  field :description, type: String
  field :content, type: String
  field :created, type: DateTime
  field :updated, type: DateTime
  field :image, type: String
  field :status, type: Mongoid::Boolean
  field :viewd, type: Integer
  field :tags, type: Array
end

class Category
  include Mongoid::Document

  has_many :blogs, dependent: :destroy

  field :slug, type: String
  field :name, type: String
  field :description, type: String
  field :content, type: String
  field :created, type: DateTime
  field :updated, type: DateTime
  field :image, type: String
  field :status, type: Mongoid::Boolean
end

class Category
  include Mongoid::Document

  has_many :blogs, dependent: :destroy

  field :slug, type: String
  field :name, type: String
  field :description, type: String
  field :content, type: String
  field :created, type: DateTime, default: Time.now
  field :updated, type: DateTime, default: Time.now
  field :image, type: String
  field :status, type: Boolean, default: true

  validates_uniqueness_of :slug
end

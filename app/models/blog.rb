class Blog
  include Mongoid::Document

  has_many :comments, dependent: :destroy
  belongs_to :category, validate: true

  field :category_id, type: String
  field :slug, type: String
  field :name, type: String
  field :description, type: String
  field :content, type: String
  field :created, type: DateTime, default: Time.now
  field :updated, type: DateTime, default: Time.now
  field :image, type: String
  field :status, type: Boolean, default: true
  field :viewd, type: Integer
  field :tags, type: Array
end

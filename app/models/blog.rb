class Blog
  include Mongoid::Document

  searchkick

  has_many :comments, dependent: :destroy
  belongs_to :category, validate: true
  belongs_to :user, validate: true

  field :category_id, type: String
  field :user_id, type: String
  field :slug, type: String
  field :name, type: String
  field :description, type: String
  field :content, type: String
  field :created, type: DateTime, default: Time.now
  field :updated, type: DateTime, default: Time.now
  field :image, type: String
  field :status, type: Boolean, default: true
  field :viewed, type: Integer
  field :tags, type: Array
  field :state, type: String

  validates_uniqueness_of :slug
end

class Page
  include Mongoid::Document

  belongs_to :user, dependent: :nullify

  field :user_id, type: String
  field :slug, type: String
  field :name, type: String
  field :description, type: String
  field :content, type: String
  field :created, type: DateTime, default: Time.now
  field :updated, type: DateTime, default: Time.now
  field :image, type: String
  field :status, type: Boolean, default: true
  field :viewed, type: Integer, default: 0
  field :state, type: String

  validates_uniqueness_of :slug
end

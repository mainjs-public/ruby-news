class Comment
  include Mongoid::Document

  has_many :comments, dependent: :destroy

  belongs_to :blog, validate: true

  field :name, type: String
  field :email, type: String
  field :website, type: String
  field :blog_id, type: String
  field :comment, type: String
  field :created, type: DateTime
end

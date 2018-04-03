class Comment
  include Mongoid::Document

  has_many :comments, dependent: :destroy

  belongs_to :blog, validate: true
  belongs_to :comment, validate: true

  field :title, type: String
  field :content, type: String
  field :blog_id, type: String
  field :created, type: DateTime
  field :status, type: Mongoid::Boolean
end

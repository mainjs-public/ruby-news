include ActiveModel::SecurePassword
class User
  include Mongoid::Document
  has_secure_password

  has_many :blogs, dependent: :restrict

  field :name, type: String
  field :email, type: String
  field :role, type: String
  field :password_digest, type: String
  validates_presence_of :name, :email
  validates_uniqueness_of :email
end

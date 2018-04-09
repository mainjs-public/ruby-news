class Setting
  include Mongoid::Document
  field :json, type: Mongoid::Boolean
  field :key, type: String
  field :value, type: String

  validates :key, uniqueness: true
end

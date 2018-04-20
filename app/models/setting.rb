class Setting
  include Mongoid::Document
  field :json, type: Mongoid::Boolean
  field :key, type: String
  field :value, type: String

  validates_uniqueness_of :key
end

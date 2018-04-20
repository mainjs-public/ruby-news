Types::CategoryType = GraphQL::ObjectType.define do
  # this type is named 'Category'
  name 'Category'

  field :id, types.ID
  field :slug, !types.String
  field :name, !types.String
  field :description, !types.String
  field :created, !Types::DateTimeType
  field :updated, !Types::DateTimeType
  field :image, !types.String
  field :status, !types.Boolean
  field :blogs, -> {!types[Types::BlogType]}
end
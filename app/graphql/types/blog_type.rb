Types::BlogType = GraphQL::ObjectType.define do
  # this type is named 'Blog'
  name 'Blog'

  field :id, !types.ID
  field :slug, !types.String
  field :name, !types.String
  field :description, !types.String
  field :content, !types.String
  field :created, !Types::DateTimeType
  field :updated, !Types::DateTimeType
  field :image, !types.String
  field :viewed, !types.Int
  field :tag, !types[types.String]
  field :status, !types.Boolean
  field :category, -> {Types::CategoryType}
  field :comments, -> {!types[Types::CommentType]}
end
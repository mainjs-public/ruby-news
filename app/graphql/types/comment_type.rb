Types::CommentType = GraphQL::ObjectType.define do
  # this type is named 'Comment'
  name 'Comment'

  field :id, !types.ID
  field :name, !types.String
  field :email, !types.String
  field :website, types.String
  field :comment, !types.String
  field :created, Types::DateTimeType
end
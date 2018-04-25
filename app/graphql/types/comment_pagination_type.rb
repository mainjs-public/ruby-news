Types::CommentPaginationType = GraphQL::ObjectType.define do
  name 'CommentPagination'

  field :start, !types.Int
  field :length, !types.Int
  field :count, !types.Int
  field :data, -> {!types[Types::CommentType]}
end
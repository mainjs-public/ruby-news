Types::BlogPaginationType = GraphQL::ObjectType.define do
  name 'BlogPagination'

  field :start, !types.Int
  field :length, !types.Int
  field :count, !types.Int
  field :data, -> {!types[Types::BlogType]}
end
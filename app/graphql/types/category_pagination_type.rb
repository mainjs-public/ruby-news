Types::CategoryPaginationType = GraphQL::ObjectType.define do
  name 'CategoryPagination'

  field :start, !types.Int
  field :length, !types.Int
  field :count, !types.Int
  field :data, -> {!types[Types::CategoryType]}
  field :hasNextPage, !types.Boolean
end
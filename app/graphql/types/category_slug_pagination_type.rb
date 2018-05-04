Types::CategorySlugPaginationType = GraphQL::ObjectType.define do
  name 'CategorySlugPagination'

  field :category, Types::CategoryType
  field :start, !types.Int
  field :length, !types.Int
  field :count, !types.Int
  field :data, -> {!types[Types::BlogType]}
  field :hasNextPage, !types.Boolean
end
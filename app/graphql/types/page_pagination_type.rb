Types::PagePaginationType = GraphQL::ObjectType.define do
  name 'PagePagination'

  field :start, !types.Int
  field :length, !types.Int
  field :count, !types.Int
  field :data, -> {!types[Types::PageType]}
  field :hasNextPage, !types.Boolean
end
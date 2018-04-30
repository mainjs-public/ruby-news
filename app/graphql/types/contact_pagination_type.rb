Types::ContactPaginationType = GraphQL::ObjectType.define do
  name 'ContactPagination'

  field :start, !types.Int
  field :length, !types.Int
  field :count, !types.Int
  field :data, -> {!types[Types::ContactType]}
  field :hasNextPage, !types.Boolean
end
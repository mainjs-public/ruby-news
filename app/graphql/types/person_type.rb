Types::PersonType = GraphQL::ObjectType.define do
  # this type is named 'Person'
  name 'Person'

  field :id, !types.ID
  field :first_name, !types.String
  field :last_name, !types.String
  field :email, !types.String
  field :notes, !types.String
end
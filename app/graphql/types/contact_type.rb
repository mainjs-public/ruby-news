Types::ContactType = GraphQL::ObjectType.define do
  name "Contact"
  field :firstName, types.String
  field :lastName, types.String
  field :email, types.String
  field :phone, types.String
  field :message, types.String
  field :read, !types.Boolean
end


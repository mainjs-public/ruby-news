Types::ContactType = GraphQL::ObjectType.define do
  name "Contact"
  field :fistName, types.String
  field :lastname, types.String
  field :email, types.String
  field :phone, types.String
  field :message, types.String
  field :read, !types.Boolean
end


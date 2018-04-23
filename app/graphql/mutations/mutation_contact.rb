Mutations::MutationContact = GraphQL::Relay::Mutation.define do
  name "MutationContact"
  description 'Add contact or update contact'

  return_type Types::ContactType

  input_field :id, types.ID
  input_field :firstName, !types.String
  input_field :lastName, !types.String
  input_field :email, types.String
  input_field :phone, types.String
  input_field :message, types.String
  input_field :read, types.Boolean

  resolve ->(obj, inputs, ctx) {
    if inputs[:id]
      contact = Contact.find(inputs[:id])
      contact.update(
          firstName: inputs[:slug],
          lastName: inputs[:name],
          email: inputs[:description],
          phone: inputs[:image],
          message: inputs[:status],
          read: inputs[:status],
          )
      contact
    else
      Contact.create!(
          firstName: inputs[:slug],
          lastName: inputs[:name],
          email: inputs[:description],
          phone: inputs[:image],
          message: inputs[:status],
          read: inputs[:status],
          )
    end
  }
end

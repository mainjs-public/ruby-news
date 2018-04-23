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
          firstName: inputs[:firstName],
          lastName: inputs[:lastName],
          email: inputs[:email],
          phone: inputs[:phone],
          message: inputs[:message],
          read: inputs[:read],
          )
      contact
    else
      Contact.create!(
          firstName: inputs[:firstName],
          lastName: inputs[:lastName],
          email: inputs[:email],
          phone: inputs[:phone],
          message: inputs[:message],
          read: inputs[:read],
          )
    end
  }
end

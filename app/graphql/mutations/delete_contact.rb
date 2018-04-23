Mutations::DeleteContact = GraphQL::Relay::Mutation.define do
  name "DeleteContact"
  description "Delete Contact By ID"

  input_field :contactId, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
    response = {
    	count: Contact.where(id: args[:contactId]).delete
    }
  }
end

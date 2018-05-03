Mutations::DeleteContact = GraphQL::Relay::Mutation.define do
  name "DeleteContact"
  description "Delete Contact By ID"

  input_field :contactId, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
  	unless ctx[:current_user]
  	 	GraphQL::ExecutionError.new("You don't have permission to mutation data.")
  	else
	    response = {
	    	count: Contact.where(id: args[:contactId]).delete
	    }
	end
  }
end

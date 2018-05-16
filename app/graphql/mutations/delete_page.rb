Mutations::DeletePage = GraphQL::Relay::Mutation.define do
  name "DeletePage"
  description "Delete Page By ID"
  
  input_field :pageId, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
  	unless ctx[:current_user]
  	 	GraphQL::ExecutionError.new("You don't have permission to mutation data.")
  	else
	    response = {
	    	count: Page.where(id: args[:pageId]).delete
	    }
	end
  }
end

Mutations::DeleteCategory = GraphQL::Relay::Mutation.define do
  name "DeleteCategory"
  description "Delete Category By ID" 

  input_field :categoryId, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
  	unless ctx[:current_user]
  	 	GraphQL::ExecutionError.new("You don't have permission to mutation data.")
  	else
	    response = {
	    	count: Category.where(id: args[:categoryId]).delete
	    }
	end	
  }
end

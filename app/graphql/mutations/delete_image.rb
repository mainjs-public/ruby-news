Mutations::DeleteImage = GraphQL::Relay::Mutation.define do
  name "DeleteImage"
  description "Delete image by ID"

  input_field :id, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
  	unless ctx[:current_user]
  	 	GraphQL::ExecutionError.new("You don't have permission to mutation data.")
  	else
	    response = {
	        count: Image.where(id: args[:id]).delete
	    }
	end
  }
end

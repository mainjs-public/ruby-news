Mutations::DeleteFolder = GraphQL::Relay::Mutation.define do
  name "DeleteFolder"

  description "Delete folder by ID"

  input_field :id, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {

  	unless ctx[:current_user]
  	 	GraphQL::ExecutionError.new("You don't have permission to mutation data.")
  	else
	  	response = {
	        count: Folder.where(id: args[:id]).delete
	    }
    end
  }
end

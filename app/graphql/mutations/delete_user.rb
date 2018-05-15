Mutations::DeleteUser = GraphQL::Relay::Mutation.define do
  name "DeleteUser"
  description "Delete User By ID"
  
  input_field :userId, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
  	unless ctx[:current_user]
  	 	GraphQL::ExecutionError.new("You don't have permission to mutation data.")
  	else
	    response = {
	    	count: User.where(id: args[:userId]).delete
	    }
	end
  }
end

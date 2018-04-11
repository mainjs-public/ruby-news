Mutations::DeleteCategory = GraphQL::Relay::Mutation.define do
  name "DeleteCategory"
  description "Delete Category By ID" 

  input_field :categoryId, !types.ID

  return_field :count, types.String

  resolve ->(obj, args, ctx) {
    response = {
    	count: Category.where(id: args[:categoryId]).delete
    }
  }
end

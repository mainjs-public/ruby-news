Mutations::DeleteBlog = GraphQL::Relay::Mutation.define do
  name "DeleteBlog"
  description "Delete Blog By ID"
  
  input_field :blogId, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
    response = {
    	count: Blog.where(id: args[:blogId]).delete
    }
  }
end

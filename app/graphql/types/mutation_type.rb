Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :deleteBlog, Mutations::DeleteBlog.field
  field :mutationBlog, Mutations::MutationBlog.field
  field :deleteCategory, Mutations::DeleteCategory.field
  field :mutationCategory, Mutations::MutationCategory.field
  field :addSetting, Mutations::AddSetting.field

  field :createUser, function: Functions::CreateUser.new
  field :signIn, function: Functions::SignInUser.new
end

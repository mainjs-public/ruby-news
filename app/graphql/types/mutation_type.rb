Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :mutationContact, Mutations::MutationContact.field
  field :updateSetting, Mutations::UpdateSetting.field
  field :deleteImage, Mutations::DeleteImage.field
  field :deleteBlog, Mutations::DeleteBlog.field
  field :deleteFolder, Mutations::DeleteFolder.field
  field :createFolder, Mutations::CreateFolder.field
  field :mutationBlog, Mutations::MutationBlog.field
  field :deleteCategory, Mutations::DeleteCategory.field
  field :deleteContact, Mutations::DeleteContact.field
  field :mutationCategory, Mutations::MutationCategory.field
  field :addSetting, Mutations::AddSetting.field

  field :createUser, function: Functions::CreateUser.new
  field :signIn, function: Functions::SignInUser.new
end

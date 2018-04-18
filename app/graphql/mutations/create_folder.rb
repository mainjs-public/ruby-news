Mutations::CreateFolder = GraphQL::Relay::Mutation.define do
  name "CreateFolder"

  description "Create folder"

  return_type Types::FolderType

  input_field :name, !types.String
  input_field :path, !types.String

  resolve ->(obj, inputs, ctx) {
    Folder.create!(
        name: inputs[:name],
        path: inputs[:path]
    )
  }
end

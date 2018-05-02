Mutations::CreateFolder = GraphQL::Relay::Mutation.define do
  name "CreateFolder"

  description "Create folder"

  return_type Types::FolderType

  input_field :name, !types.String
  input_field :path, !types.String

  resolve ->(obj, inputs, ctx) {
    unless ctx[:current_user]
      GraphQL::ExecutionError.new("You don't have permission to mutation data.")
    else
      Folder.create!(
          name: inputs[:name],
          path: inputs[:path]
      )
    end
  }
end

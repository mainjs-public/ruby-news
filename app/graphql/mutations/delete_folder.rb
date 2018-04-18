Mutations::DeleteFolder = GraphQL::Relay::Mutation.define do
  name "DeleteFolder"

  description "Delete folder by ID"

  input_field :id, !types.ID

  return_field :count, types.Int

  resolve ->(obj, args, ctx) {
    response = {
        count: Folder.where(id: args[:id]).delete
    }
  }
end

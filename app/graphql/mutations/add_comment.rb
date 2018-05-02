Mutations::AddComment = GraphQL::Relay::Mutation.define do
  name "AddComment"
  description 'Add Comment'

  return_type Types::CommentType

  input_field :name, !types.String
  input_field :email, !types.String
  input_field :website, types.String
  input_field :comment, !types.String

  resolve ->(obj, args, ctx) {
    Setting.create!(
        name: args[:name],
        email: args[:email],
        website: args[:website],
        comment: args[:comment]
    )
  }
end

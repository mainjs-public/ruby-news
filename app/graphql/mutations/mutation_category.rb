Mutations::MutationCategory = GraphQL::Relay::Mutation.define do
  name "MutationCategory"
  description 'Add category and Update Category'
  # TODO: define return fields
  # return_field :post, Types::PostType
  return_type Types::CategoryType

  # TODO: define arguments
  # input_field :name, !types.String

  input_field :slug, !types.String
  input_field :name, !types.String
  input_field :description, !types.String
  input_field :content, !types.String
  input_field :image, !types.String
  input_field :status, !types.Boolean

  resolve ->(obj, inputs, ctx) {
    Category.create!(
        slug: inputs[:slug],
        name: inputs[:name],
        description: inputs[:description],
        content: inputs[:content],
        image: inputs[:image],
        status: inputs[:status],
    )
  }
end

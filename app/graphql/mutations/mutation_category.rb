Mutations::MutationCategory = GraphQL::Relay::Mutation.define do
  name "MutationCategory"
  description 'Add category and update category'

  return_type Types::CategoryType

  input_field :id, types.ID
  input_field :slug, !types.String
  input_field :name, !types.String
  input_field :description, types.String
  input_field :image, types.String
  input_field :status, types.Boolean

  resolve ->(obj, inputs, ctx) {
    unless ctx[:current_user]
      GraphQL::ExecutionError.new("You don't have permission to mutation data.")
    else
      if inputs[:id]
        category = Category.find(inputs[:id])
        category.update(
            slug: inputs[:slug],
            name: inputs[:name],
            description: inputs[:description],
            image: inputs[:image],
            status: inputs[:status],
            )
        category
      else
        Category.create!(
            slug: inputs[:slug],
            name: inputs[:name],
            description: inputs[:description],
            image: inputs[:image],
            status: inputs[:status],
            )
      end
    end
  }
end

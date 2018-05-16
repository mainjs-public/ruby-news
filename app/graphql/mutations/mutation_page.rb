Mutations::MutationPage = GraphQL::Relay::Mutation.define do
  name "MutationPage"
  description 'Add page and update page'
  return_type Types::CategoryType

  input_field :id, types.ID
  input_field :slug, !types.String
  input_field :name, !types.String
  input_field :description, types.String
  input_field :content, types.String
  input_field :image, types.String
  input_field :status, types.Boolean
  input_field :state, types.String

  resolve ->(obj, inputs, ctx) {
    unless ctx[:current_user]
      GraphQL::ExecutionError.new("You don't have permission to mutation data.")
    else
      if inputs[:id]
        page = Page.find(inputs[:id])
        page.update(
            slug: inputs[:slug],
            name: inputs[:name],
            description: inputs[:description],
            content: inputs[:content],
            image: inputs[:image],
            status: inputs[:status],
            state: inputs[:state],
          )
        page
      else
        Page.create!(
            slug: inputs[:slug],
            name: inputs[:name],
            description: inputs[:description],
            content: inputs[:content],
            image: inputs[:image],
            status: inputs[:status],
            state: inputs[:state],
            user_id: ctx[:current_user].id
          )
      end
    end
  }
end

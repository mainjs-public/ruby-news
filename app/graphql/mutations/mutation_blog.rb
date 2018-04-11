Mutations::MutationBlog = GraphQL::Relay::Mutation.define do
  name "MutationCategory"
  description 'Add blog and update blog'
  return_type Types::CategoryType

  input_field :category_id, type: String
  input_field :slug, type: String
  input_field :name, type: String
  input_field :description, type: String
  input_field :content, type: String
  input_field :created, type: DateTime, default: Time.now
  input_field :updated, type: DateTime, default: Time.now
  input_field :image, type: String
  input_field :status, type: Boolean, default: true
  input_field :tags, type: Array

  resolve ->(obj, inputs, ctx) {
    Blog.create!(
        category_id: inputs[:category_id],
        slug: inputs[:slug],
        name: inputs[:name],
        description: inputs[:description],
        content: inputs[:content],
        image: inputs[:image],
        status: inputs[:status],
        status: 0,
        tags: [],
        )
  }
end

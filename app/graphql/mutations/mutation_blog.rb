Mutations::MutationBlog = GraphQL::Relay::Mutation.define do
  name "MutationBlog"
  description 'Add blog and update blog'
  return_type Types::CategoryType

  input_field :category_id, types.ID
  input_field :id, types.ID
  input_field :slug, !types.String
  input_field :name, !types.String
  input_field :description, types.String
  input_field :content, types.String
  input_field :image, types.String
  input_field :status, types.Boolean
  input_field :tags, types[types.String]

  resolve ->(obj, inputs, ctx) {
    if inputs[:id]
      blog = Blog.find(inputs[:id])
      blog.update(
          category_id: inputs[:category_id],
          slug: inputs[:slug],
          name: inputs[:name],
          description: inputs[:description],
          content: inputs[:content],
          image: inputs[:image],
          status: inputs[:status],
          tags: inputs[:tags],
          )
      blog
    else
      Blog.create!(
          category_id: inputs[:category_id],
          slug: inputs[:slug],
          name: inputs[:name],
          description: inputs[:description],
          content: inputs[:content],
          image: inputs[:image],
          status: inputs[:status],
          tags: inputs[:tags],
          )
    end
  }
end

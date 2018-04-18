Types::ImageType = GraphQL::ObjectType.define do
  name "Image"

  field :id, types.ID
  field :folder_id, types.ID
  field :name, types.String
  field :path, types.String
  field :created, Types::DateTimeType
end

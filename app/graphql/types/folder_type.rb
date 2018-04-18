Types::FolderType = GraphQL::ObjectType.define do
  name "Folder"

  field :id, types.ID
  field :name, types.String
  field :path, types.String
  field :created, Types::DateTimeType
  field :images, -> {!types[Types::ImageType]}
end

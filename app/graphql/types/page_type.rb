Types::PageType = GraphQL::ObjectType.define do
  # this type is named 'Page'
  name 'Page'

  field :id, !types.ID
  field :slug, !types.String
  field :name, !types.String
  field :description, !types.String
  field :content, !types.String
  field :created, !Types::DateTimeType
  field :updated, !Types::DateTimeType
  field :image, !types.String
  field :viewed, !types.Int
  field :status, !types.Boolean
  field :state, !types.String
  field :user, -> {Types::UserType}
end
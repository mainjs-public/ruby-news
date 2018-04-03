Types::CommentType = GraphQL::ObjectType.define do
	# this type is named 'Comment'
	name 'Comment'

	field :id, !types.ID
	field :title, !types.String
	field :content, !types.String
	field :created, !Types::DateTimeType
	field :status, !types.Boolean
	field :blog, -> { Types::BlogType }
	field :comments, -> { !types[Types::CommentType] }
end
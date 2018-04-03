Types::SettingType = GraphQL::ObjectType.define do
	# this type is named 'Setting'
	name 'Setting'

	field :id, !types.ID
	field :key, !types.String
	field :json, !types.Boolean
	field :value, !types.String
end
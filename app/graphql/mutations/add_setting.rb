Mutations::AddSetting = GraphQL::Relay::Mutation.define do
  name 'AddSetting'
  description 'Add setting'

  return_type Types::SettingType

  input_field :key, !types.String
  input_field :json, !types.Boolean
  input_field :value, !types.String

  resolve ->(obj, args, ctx) {
    Setting.create!(
        key: args[:slug],
        json: args[:json],
        value: args[:value]
    )
  }
end

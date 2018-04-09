Mutations::AddSetting = GraphQL::Relay::Mutation.define do
  name 'AddSetting'
  description 'Add setting'

  return_type Types::SettingType

  input_field :key, !types.String
  input_field :json, !types.Boolean
  input_field :value, !types.String

  resolve ->(obj, inputs, ctx) {
    Setting.create!(
        key: inputs[:key],
        json: inputs[:json],
        value: inputs[:value]
    )
  }
end

Mutations::UpdateSetting = GraphQL::Relay::Mutation.define do
  name "UpdateSetting"
  description "Update or Create a setting"

  return_type Types::SettingType

  input_field :key, !types.String
  input_field :json, !types.Boolean
  input_field :value, !types.String

  resolve ->(obj, args, ctx) {
    unless ctx[:current_user]
      GraphQL::ExecutionError.new("You don't have permission to mutation data.")
    else
      if Setting.where(key: args[:key]).exists?
        setting = Setting.find_by(key: args[:key]) do |setting|
          setting.json = args[:json]
          setting.value = args[:value]
        end
        setting.save
        return setting
      end
      Setting.find_or_create_by(key: args[:key]) do |setting|
        setting.json = args[:json]
        setting.value = args[:value]
      end
    end
  }
end

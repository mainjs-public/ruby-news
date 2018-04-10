Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :mutationCategory, Mutations::MutationCategory.field
  field :addSetting, Mutations::AddSetting.field
  # TODO: Remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end

  field :createPerson, Types::PersonType do
    description "Create a person"

    argument :first_name, !types.String
    argument :last_name, !types.String
    argument :email, !types.String
    argument :notes, !types.String

    resolve ->(obj, args, ctx) {
      Person.create!(
          first_name: args[:first_name],
          last_name: args[:last_name],
          email: args[:email],
          notes: args[:notes],
          )
    }
  end
end

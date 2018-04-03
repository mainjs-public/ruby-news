Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end

  field :persons, !types[Types::PersonType] do
    resolve -> (obj, args, ctx) { Person.all }
  end

  field :settings, !types[Types::SettingType] do
    resolve -> (obj, args, ctx) { Setting.all }
  end

  field :categories, !types[Types::CategoryType] do
    resolve -> (obj, args, ctx) { Category.all }
  end

  field :blogs, !types[Types::BlogType] do
    resolve -> (obj, args, ctx) { Blog.all }
  end
end

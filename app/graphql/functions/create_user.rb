class Functions::CreateUser < GraphQL::Function
  description 'Create User'
  # Define `initialize` to store field-level options, eg
  #
  #     field :myField, function: Functions::CreateUser.new(type: MyType)
  #
  # attr_reader :type
  # def initialize(type:)
  #   @type = type
  # end

  # add arguments by type:
  argument :name, !types.String
  argument :email, !types.String
  argument :role, !types.String
  argument :password, !types.String

  type Types::UserType

  # Resolve function:
  def call(obj, args, ctx)
    User.create!(
        name: args[:name],
        email: args[:email],
        role: args[:role],
        password: args[:password],
    )
  end
end

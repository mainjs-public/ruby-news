class Functions::UpdateUser < GraphQL::Function
  description 'Update User'
  # Define `initialize` to store field-level options, eg
  #
  #     field :myField, function: Functions::UpdateUser.new(type: MyType)
  #
  # attr_reader :type
  # def initialize(type:)
  #   @type = type
  # end

  # add arguments by type:
  # argument :id, !types.ID
  argument :name, !types.String
  argument :email, !types.String
  argument :role, !types.String
  argument :password, types.String

  type Types::UserType

  # Resolve function:
  def call(obj, args, ctx)
    user = User.find_by(email: args[:email])
    return unless user
    if args[:password]
      user.update(
          name: args[:name],
          email: args[:email],
          role: args[:role],
          password: args[:password],
      )
    else
      user.update(
          name: args[:name],
          email: args[:email],
          role: args[:role],
      )
    end
    user
  end
end

class Functions::SignInUser < GraphQL::Function
  # Define `initialize` to store field-level options, eg
  #
  #     field :myField, function: Functions::SignInUser.new(type: MyType)
  #
  # attr_reader :type
  # def initialize(type:)
  #   @type = type
  # end

  # add arguments by type:
  argument :email, !types.String
  argument :password, !types.String

  type do
    name 'SigninPayload'
    field :token, types.String
    field :user, Types::UserType
  end

  # Resolve function:
  def call(obj, args, ctx)

    user = User.find_by email: args[:email]

    # ensures we have the correct user
    return unless user
    return unless user.authenticate(args[:password])

    # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    ctx[:session][:token] = token

    OpenStruct.new({
                       token: token,
                       user: user
                   })
  end
end

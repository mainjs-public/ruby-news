require 'jwt'

class Functions::SignInUser < GraphQL::Function

  description 'SignIn'

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

    # puts user._id

    payload = {
        context: {
            user: {
                id: user._id.to_s,
                email: user.email,
                role: user.role
            }
        }
    }

    hmac_secret = Rails.configuration.jwt['hmac_secret']

    token = JWT.encode payload, hmac_secret, 'HS256'

    # decoded_token = JWT.decode token, hmac_secret, true, {algorithm: 'HS256'}
    #
    # puts decoded_token

    OpenStruct.new({token: token, user: user})
  end
end

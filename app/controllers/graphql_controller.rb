require 'jwt'
class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
        current_user: current_user,
    }
    result = New24Schema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def current_user
    hmac_secret = Rails.configuration.jwt['hmac_secret']
    # token = "eyJhbGciOiJIUzI1NiJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiaWQiOiI1YWQ4NWU4ZmRmYmEzMDIwMmMwNTU4YWQiLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSJ9fX0.hbu-bGjFtYRQ9izOK9AVz7mElU9pmcFXEmaX5vEpjs4"
    token = request.headers["Authorization"]
    # puts request.headers["Authorization"]

    decoded_token = JWT.decode token, hmac_secret, true, {algorithm: 'HS256'}
    user_id = decoded_token[0]['context']['user']['id']
    user = User.find_by id: user_id
    user
  rescue JWT::DecodeError
    nil
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end

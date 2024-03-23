require 'jwt'

class SessionController < ApplicationController
  def signup
    user = User.new(email: param[:email], password: password[:password])

    # if user is saved
    if user.save
      token = encode_user_data({ user_data: user.id })

      # return to user
      render json: { token: token }
    else
      # render error message
      render json: { message: "invalid credentials" }
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def encode_token(payload)
    JWT.encode payload, 'myspecialkey', 'HS256'
  end

  # def login
  #   puts "test1"
  #   puts params
  #   user = User.find_by(email: params[:email])

  #   # you can use bcrypt to password authentication
  #   if user && user.password_digest == params[:password]

  #     # we encrypt user info using the pre-define methods in application controller
  #     token = encode_user_data({ user_data: user.id })

  #     # return to user
  #     render json: { token: token }
  #   else
  #     render json: { message: "invalid credentials" }
  #   end
  # end
end

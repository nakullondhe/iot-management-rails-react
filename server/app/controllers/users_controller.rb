class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      puts "test22"
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def get
    render json: {message: "User", user: @user}, status: :created
  end

  private

  def user_params
    params.require("user").permit(:email,:password)
  end

end

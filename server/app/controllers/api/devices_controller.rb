require 'jwt'
class Api::DevicesController < ApplicationController
  before_action :authorize_request, only: [:create, :update, :destroy]
  before_action :set_device, only: [:show, :update, :destroy]
  SECRET = "myspecialkey"

    def index
      @devices = Device.all
      render json: @devices
    end

    def show
      render json: @device
    end
    
    def create
      @device = Device.new(device_params)
      if @device.save
        render json: @device, status: :created
      else
        render json: @device.errors, status: :unprocessable_entity
      end
    end

    def update
      if @device.update(device_params)
        render json: @device
      else
        render json: @device.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @device.destroy
      head :no_content
    end

    private

    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params.require(:device).permit(:name, :device_id, :model,:serial_number, :system_id, :unit, :active)
    end


  
    private

    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = decode_token(header)
        puts @decoded.first["user_id"]
        @current_user = User.find(@decoded.first['user_id']) if @decoded
  
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

    def decode_token(token)
      JWT.decode token, SECRET, true, { algorithm: "HS256" }
    end

end

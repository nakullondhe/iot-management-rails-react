require 'redis'

class Api::AlarmsController < ApplicationController
  before_action :set_alarm, only: [:show, :update, :destroy]
  
  def initialize
    @redis = Redis.new(host: 'localhost', port: 6379)
  end

  def index
    @alarms = Alarm.all
    render json: @alarms
  end

  def show
  end

  def create
    @alarm = Alarm.new(alarm_params)
    
    begin
      redis_key = "device/#{@alarm.device_id}/#{@alarm.threshold}" 
      puts redis_key
      # log redis_key

      @redis.set(redis_key, 1)
      if @alarm.save
        render json: @alarm, status: :created
      end
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # /alarms/1
  def update
    if @alarm.update(alarm_params)
      render json: @alarm, status: :ok
    else
      render json: @alarm.errors, status: :unprocessable_entity
    end
  end

  # Delete /alarms/1
  def destroy
    @alarm.destroy
  end

  def active_by_device_id
    begin
      @alarms = Alarm.where(device_id: params[:device_id], triggered: 0)
      render json: @alarms, status: :ok
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def all_triggered
    begin 
      @alarms = Alarm.where(triggered: 1)
      render json: @alarms, status: :ok
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  private

  def set_alarm
    @alarm = Alarm.find(params[:id])
  end

  def alarm_params
    params.require(:alarm).permit(:device_id, :severity, :threshold)
  end

end

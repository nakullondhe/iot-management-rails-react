class Api::AlarmsController < ApplicationController
  before_action :set_alarm, only: [:show, :update, :destroy]

  def index
    @alarms = Alarm.all
    render json: @alarms
  end

  def show
  end

  def create
    @alarm = Alarm.new(alarm_params)

    if @alarm.save
      render json: @alarm, status: :created
    else
      render json: @alarm.errors, status: :unprocessable_entity
    end
  end

  # /alarms/1
  def update
    if @alarm.update(alarm_params)
      render json: @alarm
    else
      render json: @alarm.errors, status: :unprocessable_entity
    end
  end

  # Delete /alarms/1
  def destroy
    @alarm.destroy
  end

  private

  def set_alarm
    @alarm = Alarm.find(params[:id])
  end

  def alarm_params
    params.require(:alarm).permit(:device_id, :severity, :acknowledged)
  end

end

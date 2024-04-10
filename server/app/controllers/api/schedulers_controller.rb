
class Api::SchedulersController < ApplicationController
  before_action :set_scheduler, only: %i[show update destroy]

  def index
    @schedulers = Scheduler.order(created_at: :desc)
    render json: @schedulers
  end


  def show
    render json: @scheduler
  end

  def create
    scheduler = Scheduler.create(scheduler_params)
    if scheduler.save
      # Schedule the cron job
      render json: scheduler, status: :created
    else
      render json: scheduler.errors, status: :unprocessable_entity
    end
  end

  def edit # rubocop:disable Style/EmptyMethod
  end

  def update
    if @scheduler.update(scheduler_params)
      redirect_to @scheduler
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @scheduler.destroy
    render json: { message: 'Scheduler was successfully deleted' }
  end

  private

  def scheduler_params
    params.require(:scheduler).permit(:name,:device_id, :date_time, :action, :executed, :canceled)
  end

  def set_scheduler
    begin
      @scheduler = Scheduler.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Scheduler not found for id :' + params[:id].to_s }, status: :not_found
    end
  end
end

class Api::PotsController < ApplicationController
  before_action :set_api_pot, only: %i[ show update destroy ]

  # GET /api/pots
  # GET /api/pots.json
  def index
    @api_pots = Api::Pot.all
  end

  # GET /api/pots/1
  # GET /api/pots/1.json
  def show
  end

  # POST /api/pots
  # POST /api/pots.json
  def create
    @api_pot = Api::Pot.new(api_pot_params)

    if @api_pot.save
      render :show, status: :created, location: @api_pot
    else
      render json: @api_pot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/pots/1
  # PATCH/PUT /api/pots/1.json
  def update
    if @api_pot.update(api_pot_params)
      render :show, status: :ok, location: @api_pot
    else
      render json: @api_pot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/pots/1
  # DELETE /api/pots/1.json
  def destroy
    @api_pot.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_pot
      @api_pot = Api::Pot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_pot_params
      params.require(:api_pot).permit(:title, :context)
    end
end

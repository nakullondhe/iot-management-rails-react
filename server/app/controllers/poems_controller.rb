class PoemsController < ApplicationController
  before_action :set_poem, only: %i[ show update destroy ]

  # GET /poems
  # GET /poems.json
  def index
    @poems = Poem.all
  end

  # GET /poems/1
  # GET /poems/1.json
  def show
  end

  # POST /poems
  # POST /poems.json
  def create
    @poem = Poem.new(poem_params)

    if @poem.save
      render :show, status: :created, location: @poem
    else
      render json: @poem.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /poems/1
  # PATCH/PUT /poems/1.json
  def update
    if @poem.update(poem_params)
      render :show, status: :ok, location: @poem
    else
      render json: @poem.errors, status: :unprocessable_entity
    end
  end

  # DELETE /poems/1
  # DELETE /poems/1.json
  def destroy
    @poem.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poem
      @poem = Poem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poem_params
      params.require(:poem).permit(:title, :context)
    end
end

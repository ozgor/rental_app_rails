class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  # GET /rentals
  # GET /rentals.json
  def index
    @user = User.find(params[:user_id])
    @rentals = @user.rentals.all
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
  end

  # GET /rentals/new
  def new
    @user = User.find(params[:user_id])
    @rental = @user.rentals.build
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals
  # POST /rentals.json
  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.save
        if params[:images]
          params[:images].each do |image|
            @rental.pictures.create(file: image)
          end
        end

        format.html { redirect_to [@rental.user, @rental], notice: 'Rental was successfully created.' }
        format.json { render :show, status: :created, location: [@rental.user, @rental] }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1
  # PATCH/PUT /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        if params[:images]
          @rental.pictures.destroy_all
          params[:images].each do |image|
            @rental.pictures.create(file: image)
          end
        end

        format.html { redirect_to [@rental.user, @rental], notice: 'Rental was successfully updated.' }
        format.json { render :show, status: :ok, location: [@rental.user, @rental] }
      else
        format.html { render :edit }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to user_rentals_url, notice: 'Rental was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(:name, :city_id, :kind_id, :nb_guests, :score, :user_id, :price, :instant_book,
                                     :lat, :lng, availabilities_attributes: [:id, :day, :_destroy])
    end
end

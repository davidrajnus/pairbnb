class ListingsController < ApplicationController

  # before_action :find_listing, only: [:show, :update, :edit, :destroy]
  def index
    @listings = Listing.all
    render "listings/index"
  end

  def new
    @listing = Listing.new
    render "listings/new"
  end

  

  def create
    @listing = Listing.new(listing_params)

   if @listing.save
     redirect_to @listing
   else
     @errors = @user.errors.full_messages
     flash[:error] = @errors
     render "listings/show"
     # render template: "users/new"
   end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def listing_params
        params.require(:listing).permit(:title, :description, :property_type, :room_type, :guest, :bedroom, :bathroom, :price, :address)
    end

    def find_listing
        @listing = Listing.find(params[:id])
    end

end


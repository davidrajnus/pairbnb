class TagsController < ApplicationController

  def new
    # byebug
    @listing = Listing.find(params[:listing_id]) 
    @tag = Tag.new
  end

  def create
    # listing_params.user << user_id: current_user.id
    byebug
    @tag = Tag.new(tag_params)
    @tag.listing_id = params[:listing_id]
    byebug
   if @tag.save
     redirect_to root_url
   else
     @errors = @user.errors.full_messages
     flash[:error] = @errors
     render "listings/show"
     render template: "users/new"
   end
  end
end

private
    def tag_params
        params.require(:tag).permit(:listing_id, :property_type, :room_type, :wifi, :kitchen)
    end
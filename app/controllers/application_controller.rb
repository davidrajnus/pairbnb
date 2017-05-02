class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  #Alternate checking for user_role
  # def allowed?(user:)
  #     if user.customer?
  #       flash[:notice] = "Sorry. You are not allowed to perform this action."
  #     return redirect_to some_other_url, notice: "Sorry. You do not have the permission to verify a property."
  # end

end

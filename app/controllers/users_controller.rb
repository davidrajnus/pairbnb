class UsersController < Clearance::UsersController
	#this is to be able to overide the user controller
	def new
		@user = User.new
		render template: "users/new"
	end


	def create
	   @user = User.new(user_from_params)

	   if @user.save
	     sign_in @user
	     redirect_back_or url_after_create
	   else
	     @errors = @user.errors.full_messages
	     flash[:error] = @errors
	     redirect_to root_path
	     # render template: "users/new"
	   end
	end

	# def user_from_params
	#      email = user_params.delete(:email)
	#      password = user_params.delete(:password)

	#      Clearance.configuration.user_model.new(user_params).tap do |user|
	#        user.email = email
	#        user.password = password
	#      end
	# end
	private
	def user_from_params
		params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
	end

end

class UsersController < Clearance::UsersController

	before_action :find_listing, only: [:show, :update, :edit, :destroy]
	before_action :check_admin, only: [:index]

	#method for setting default user_role, but its not working
	def set_default_role
		#user_role: [:customer, :host, :admin, :superadmin]
	  self.user_role = 0
	end

	#have a page to list all user
	def index
		@users = User.all
	end

	def new
		@user = User.new
		render template: "users/new"
	end

	def show

	end


	def create
	   @user = User.new(user_from_params)
	   #sets the default user_role as customer
	   @user.user_role = 0

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
		params.require(:user).permit(:username, :first_name, :last_name, :email,
																 :gender, :phone, :country, :birthdate, :password, :avatar)
	end

	def check_admin
		redirect '/sign_up' unless current_user.admin?
	end

	def find_listing
    @user = User.find(params[:id])
  end

end

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

	#for editting the user
	def edit
		@user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])
    #deletes fields that were not filled in the edit form
    #so that it does not stop the edit function
    update_params = user_from_params.delete_if {|k,v| v == "" || v.nil?}
    if @user.update(update_params)
    	flash[:success] = "Profile updated"
      redirect_to profile_path(current_user.id)
    else
      render 'edit'
    end
  end


	def create
	   @user = User.new(user_from_params)
	   byebug
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

module UsersHelper

  def full_name
    @user.first_name + " " + @user.last_name
  end

  def current_user
    if session["user"]
      @current_user ||= User.find_by_id(session["user"])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

end
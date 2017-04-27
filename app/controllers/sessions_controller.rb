class SessionsController < Clearance::SessionsController
    def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    # byebug
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user 
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    else
      #for first time users signing in using fb
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = root_url   
      @notice = "User created - confirm or edit details..."
    end
    sign_in(user)
    redirect_to @next, :notice => @notice
  end
end

# (byebug) auth_hash["extra"]
# #<OmniAuth::AuthHash raw_info=#<OmniAuth::AuthHash email="humannerd1989@gmail.com" id="10154650175528175" name="David Raj">>
# (byebug) auth_hash["extra"]["raw_info"]
# #<OmniAuth::AuthHash email="humannerd1989@gmail.com" id="10154650175528175" name="David Raj">
# (byebug) auth_hash["extra"]["raw_info"].email
# "humannerd1989@gmail.com"
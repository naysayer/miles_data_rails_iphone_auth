class Api::SessionsController < Api::BaseApiController
	prepend_before_filter :require_no_authentication, :only => [:create ]
	  
	  before_filter :ensure_params_exist, except: [:destroy]
	  before_filter :require_auth, only: [:destroy]
	  respond_to :json
	  
	  def create
	    resource_class.new
	    resource = User.find_for_database_authentication(:email=>params[:user_login][:email])
	    return invalid_login_attempt unless resource
	 
	    if resource.valid_password?(params[:user_login][:password])
	      sign_in("user", resource)
	      render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
	      return
	    end
	    invalid_login_attempt
	  end
	  
	  def destroy
	    sign_out(@user)
	    redirect_to new_api_user_session_path(method: :get)
	  end
	 
	  protected
	  def ensure_params_exist
	    return unless params[:user_login][:email].blank? || params[:user_login][:password].blank?
	    render :json=>{:success=>false, :message=>"Missing username or password"}, :status => 422
	  end
	 
	  def invalid_login_attempt
	    warden.custom_failure!
	    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status => 401
	  end
end

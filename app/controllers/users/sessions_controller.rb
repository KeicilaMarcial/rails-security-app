class Users::SessionsController < Devise::SessionsController
    prepend_before_action :check_captcha, only: [:create]

    def create
        self.resource = warden.authenticate!(:database_authenticatable, auth_options)

        if resource.otp_required_for_login?
        sign_out(resource)
        session[:otp_user_id] = resource.id
        session[:otp_user_id_expires_at] = 30.seconds.after
        redirect_to users_sign_in_otp_path

        else
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        respond_with resource, location: after_sign_in_path_for(resource)
        end
    end

   private

   def check_captcha
      alert_recaptcha unless verify_recaptcha
    end

    def alert_recaptcha
      self.resource = resource_class.new sign_in_params
      respond_with_navigational(resource) { render :new }
    end
end

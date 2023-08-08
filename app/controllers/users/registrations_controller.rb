# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    prepend_before_action :check_captcha, only: [:create]

    private

    def check_captcha
      return if verify_recaptcha

      self.resource = resource_class.new sign_up_params
      resource.validate
      set_minimum_password_length

      respond_with_navigational(resource) do
        flash.discard(:recaptcha_error)
        render :new
      end
    end
  end
end

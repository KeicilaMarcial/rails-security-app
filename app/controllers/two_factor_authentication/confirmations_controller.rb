# frozen_string_literal: true

module TwoFactorAuthentication
  class ConfirmationsController < ApplicationController
    def show
      redirect_to two_factor_authentication_path
    end

    def create
      if current_user.validate_and_consume_otp!(params[:otp_code])
        current_user.otp_required_for_login = true
        @recovery_codes = current_user.generate_otp_backup_codes!
        current_user.save!

        render 'two_factor_authentication/confirmations/success'
      else
        flash.now[:alert] = 'Falha ao confirmar o código 2FA'
        render 'two_factor_authentications/show'
      end
    end
  end
end

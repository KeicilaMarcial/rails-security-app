# frozen_string_literal: true

module TwoFactorAuthentication
  class RecoveryCodesController < ApplicationController
    def index
      redirect_to two_factor_authentication_path
    end

    def create
      @recovery_codes = current_user.generate_otp_backup_codes!
      current_user.save!
      render :index
    end
  end
end

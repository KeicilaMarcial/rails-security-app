class User < ApplicationRecord
    validate :password_regex
    devise :two_factor_authenticatable,
           :otp_secret_encryption_key => ENV['DEVISE_OTP_ENCRYPT_KEY']


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable

  devise :two_factor_backupable,
    otp_backup_code_length: 8,
    otp_number_of_backup_codes: 12

  serialize :otp_backup_codes, Array

  def otp_qrcode
    provision_uri = otp_provisioning_uri(email, issuer: '2FA-Demo')
    RQRCode::QRCode.new(provision_uri)
  end

 private

 def password_regex
   return if password.blank? || password =~ /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{7,}\z/

   errors.add :password, 'Password should have at least 1 uppercase and lowercase letter, 1 number and 1 special character'
 end
end
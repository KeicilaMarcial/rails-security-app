require 'bcrypt'
class UniquePasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.password_histories.each do |password_history|
      bcrypt = ::BCrypt::Password.new(password_history.encrypted_password)
      hashed_value = ::BCrypt::Engine.hash_secret(value, bcrypt.salt)
      record.errors[attribute] << "has been used previously." and return if hashed_value == password_history.encrypted_password
    end
  end
end

# frozen_string_literal: true

require 'bcrypt'
class UniquePasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.password_histories.each do |password_history|
      bcrypt = ::BCrypt::Password.new(password_history.encrypted_password)
      hashed_value = ::BCrypt::Engine.hash_secret(value, bcrypt.salt)
      next unless hashed_value == password_history.encrypted_password

      if hashed_value == password_history.encrypted_password
        record.errors[attribute] << 'Senha já utilizada.' and return false
      end
    end
  end
end

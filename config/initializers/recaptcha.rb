Recaptcha.configure do |config|
    Recaptcha.configuration.skip_verify_env.delete("test")

    config.site_key   = '6Le3X4cnAAAAALDvb-wafjLM3AhO0L9b7mchWhuR'
    config.secret_key = '6Le3X4cnAAAAAIVzpm7LpjCe5UMgZHTDZs9nSlO_'
  end

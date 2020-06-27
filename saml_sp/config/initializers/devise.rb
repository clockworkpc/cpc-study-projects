# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.secret_key = '1f2bfd53f163c0aea70b788ad44bdd03a7b6059c49217395916d3e089efc8fef8007cca5d4daac801a345c5b3d850797634b4587a0f19397912bdac0c9f2325b'

  config.mailer_sender = 'hi@chameleoncreator.com'

  config.mailer = 'RegistrationMailer'

  config.parent_mailer = 'ActionMailer::Base'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.http_authenticatable_on_xhr = true

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.send_email_changed_notification = true

  config.send_password_change_notification = true

  config.reconfirmable = false

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 8..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.scoped_views = true

  config.sign_out_via = :get

  config.warden do |manager|
    manager.failure_app = CustomFailureApp
  end

  config.invite_for = 4.days

  config.saml_create_user = true

  config.saml_update_user = true

  config.saml_default_user_key = :email

  config.saml_session_index_key = :session_index

  config.saml_use_subject = true

  config.idp_settings_adapter = nil

  config.saml_route_helper_prefix = 'saml'

  config.saml_configure do |settings|
    settings.assertion_consumer_service_url     = 'http://localhost:3000/users/saml/auth'
    settings.assertion_consumer_service_binding = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'
    settings.name_identifier_format             = 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient'
    settings.issuer                             = 'localhost'
    settings.authn_context                      = ''
    settings.idp_slo_target_url                 = 'http://localhost:4000/saml/logout'
    settings.idp_sso_target_url                 = 'http://localhost:4000/saml/auth'
    settings.idp_cert_fingerprint               = 'B9:BF:DB:FE:BA:0E:7C:37:B1:00:26:61:97:52:C5:BC:9E:F4:AC:FB:E7:19:AA:12:61:9D:8D:76:F9:16:40:61'
    settings.idp_cert_fingerprint_algorithm     = 'http://www.w3.org/2000/09/xmldsig#sha256'
  end
end

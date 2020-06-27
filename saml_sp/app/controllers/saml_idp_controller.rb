class SamlIdpController < SamlIdp::IdpController
  before_action :authenticate_user!

  def create
    if current_user
      @saml_response = encode_response(current_user)
      render template: 'saml_idp/idp/saml_post', layout: false
    end
  end
end

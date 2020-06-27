# rubocop:disable Metrics/BlockLength
# rubocop:disable Security/MarshalLoad
SamlIdp.configure do |config|
  config.x509_certificate = File.read('config/myCert.crt')
  config.secret_key = File.read('config/myKey.key')

  config.name_id.formats = { # All 2.0
    email_address: ->(principal) { principal.email },
    transient: ->(principal) { principal.id },
    persistent: ->(principal) { principal.id }
  }

  service_providers = {
    'localhost' => {
      fingerprint: File.read('config/myFingerprint'),
      metadata_url: 'http://localhost:3000/saml/metadata'
    }
  }

  config.service_provider.metadata_persister = lambda { |identifier, settings|
    fname = identifier.to_s.gsub(%r{/|:}, '_')
    FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
    File.open Rails.root.join("cache/saml/metadata/#{fname}"), 'r+b' do |f|
      Marshal.dump settings.to_h, f
    end
  }

  config.service_provider.persisted_metadata_getter = lambda { |identifier, _service_provider|
    fname = identifier.to_s.gsub(%r{/|:}, '_')
    FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
    full_filename = Rails.root.join("cache/saml/metadata/#{fname}")
    if File.file?(full_filename)
      File.open full_filename, 'rb' do |f|
        Marshal.load f
      end
    end
  }

  config.service_provider.finder = lambda { |issuer_or_entity_id|
    service_providers[issuer_or_entity_id]
  }
end
# rubocop:enable Metrics/BlockLength
# rubocop:enable Security/MarshalLoad

require 'rustici_software_cloud_v2'

module ScormCloudApi
  class Main
    def initialize
      RusticiSoftwareCloudV2.configure do |config|
        config.username = ENV['SCORM_CLOUD_APP_ID']
        config.password = ENV['SCORM_CLOUD_SECRET_KEY']

        # Configure OAuth2 access token for authorization: OAUTH
        # config.access_token = 'YOUR ACCESS TOKEN'
      end

    end

    def api_instance
      RusticiSoftwareCloudV2::AboutApi.new
    end

    def about
      begin
        result = api_instance.get_about
        p result
      rescue RusticiSoftwareCloudV2::ApiError => e
        puts "Exception when calling AboutApi->get_about: #{e}"
      end
    end



    def hello
      :hello
    end

  end
end

# Setup authorization


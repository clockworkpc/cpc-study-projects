require 'rustici_software_cloud_v2'
module ScormCloudApi
  class Main
    def initialize
      RusticiSoftwareCloudV2.configure do |config|
        config.username = ENV['SCORM_CLOUD_APP_ID']
        config.password = ENV['SCORM_CLOUD_SECRET_KEY']
        # config.access_token = 'YOUR ACCESS TOKEN'
      end
    end

    def about_api_instance
      @about_api_instance ||= RusticiSoftwareCloudV2::AboutApi.new
    end

    def course_api_instance
      @course_api_instance ||= RusticiSoftwareCloudV2::CourseApi.new
    end

    def about
      about_api_instance.get_about
    rescue RusticiSoftwareCloudV2::ApiError => e
      puts "Exception when calling AboutApi->get_about: #{e}"
    end

    def courses
      course_api_instance.get_courses
    end

    def course(id:)
      course_api_instance.get_course(id)
    end

    def course_configuration(id:)
      course_api_instance.get_course_configuration(id)
    end
  end
end

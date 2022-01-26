require './spec/helpers/browser/pages/page'

module Browser
  module Pages
    class SignIn < Page
      def username_text_field
        element(@browser.text_field(name: 'username'))
      end
    end
  end
end

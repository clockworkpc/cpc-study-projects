require 'rails_helper'
require './spec/helpers/browser/pages/manufacturer1demo/sign_in'
# require './spec/helpers/browser_test_helper'

RSpec.describe 'User account, password login method', browser: true, type: :feature do
  # before(:all) do
  #   @b = BrowserTestHelper.new(port: 3333)
  #   @b.launch_rails_server
  # end

  # after(:all) { @b.kill_rails_server }

  before do
    # @browser = @b.launch_browser
    # @h = UnifiedLoginTestHelper.new(@browser)

    @browser = Watir::Browser.new
    @h = Browser::Pages::SignIn.new(@browser)
  end

  after { @browser.close }

  # let(:password) { 'boss123' }

  context 'with Boss Login' do
    it 'signs in a boss with valid credentials' do
      @browser.goto('https://manufacturer1demo.allmoxy.com/public/login/')
      @h.username_text_field.set('boss123')
      @h.password_input.set('boss123')
      @h.login_button.click
      sleep(10)
    end
  end
end

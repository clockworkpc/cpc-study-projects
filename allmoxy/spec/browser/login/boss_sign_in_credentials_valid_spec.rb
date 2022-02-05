require 'rails_helper'
require './spec/helpers/browser/pages/sign_in'
require './spec/helpers/browser/pages/home'
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
    @s = Browser::Pages::SignIn.new(@browser)
    @h = Browser::Pages::Home.new(@browser)
  end

  # let(:password) { 'boss123' }

  context 'with Boss Login' do
    it 'signs in a boss with valid credentials' do
      @browser.goto('https://manufacturer1demo.allmoxy.com/public/login/')
      @s.username_text_field.set('boss123')
      @s.password_input.set('boss123')
      @s.login_button.click

      require 'pry'
      binding.pry
      @h.avatar_image.click
      expect(@h.home_link).to exist
    end
  end
end

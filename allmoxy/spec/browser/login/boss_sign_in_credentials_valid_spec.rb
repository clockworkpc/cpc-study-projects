require 'rails_helper'
require 'browser_test_helper'

RSpec.describe 'User account, password login method', browser: true, type: :feature do
  before(:all) do
    @b = BrowserTestHelper.new(port: 3333)
    @b.launch_rails_server
  end

  after(:all) { @b.kill_rails_server }

  before do
    @browser = @b.launch_browser
    @h = UnifiedLoginTestHelper.new(@browser)
  end

  after { @browser.close }

  # let(:password) { 'boss123' }

  context 'Boss Login' do
    it 'signs in a boss with valid credentials' do
      @browser.goto('https://manufacturer1demo.allmoxy.com/public/login/')
      @h.enter_username('boss123')
      @h.enter_password('boss123')
      wait(10)
    end
  end
end

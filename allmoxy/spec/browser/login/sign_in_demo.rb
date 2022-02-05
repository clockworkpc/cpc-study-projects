require './spec/helpers/browser/pages/sign_in'
require './spec/helpers/browser/pages/home'

@browser = Watir::Browser.new
@s = Browser::Pages::SignIn.new(@browser)
@h = Browser::Pages::Home.new(@browser)

@browser.goto('https://manufacturer1demo.allmoxy.com/public/login/')
@s.username_text_field.set('boss123')
@s.password_input.set('boss123')
@s.login_button.click

@h.avatar_image.click

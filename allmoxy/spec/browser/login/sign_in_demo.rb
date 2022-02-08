require './spec/helpers/browser/pages/sign_in'
require './spec/helpers/browser/pages/home'

pd_url = 'https://panhandledooranddrawer.allmoxy.com/login'

@browser = Watir::Browser.new(:chrome, headless: false)
@s = Browser::Pages::SignIn.new(@browser)
@h = Browser::Pages::Home.new(@browser)

@browser.goto(pd_url)
@s.username_text_field.set('agarber')
@s.password_input.set('ZWiooMyat9kPz8HmTePO')
@s.login_button.click

@h.avatar_image.click
@h.avatar_image.click

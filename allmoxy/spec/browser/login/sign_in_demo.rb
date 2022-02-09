require 'json'
require './spec/helpers/browser/pages/sign_in'
require './spec/helpers/browser/pages/home'

formula_json_file = './spec/helpers/product_parts_formulae.json'

pd_url = 'https://panhandledooranddrawer.allmoxy.com/login'
@formulae = JSON.load_file(formula_json_file)

@browser = Watir::Browser.new(:chrome, headless: false)
@s = Browser::Pages::SignIn.new(@browser)
@h = Browser::Pages::Home.new(@browser)

@browser.goto(pd_url)
@s.username_text_field.set('agarber')
@s.password_input.set('ZWiooMyat9kPz8HmTePO')
@s.login_button.click

# @h.avatar_image.click
# @h.avatar_image.click

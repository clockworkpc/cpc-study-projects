require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        name: "Name",
        email: "Email"
      ),
      Account.create!(
        name: "Name",
        email: "Email"
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
  end
end

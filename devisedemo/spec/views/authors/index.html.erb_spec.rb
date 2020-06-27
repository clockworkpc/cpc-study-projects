require 'rails_helper'

RSpec.describe "authors/index", type: :view do
  before(:each) do
    assign(:authors, [
      Author.create!(
        first_name: "First Name",
        surname: "Surname"
      ),
      Author.create!(
        first_name: "First Name",
        surname: "Surname"
      )
    ])
  end

  it "renders a list of authors" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Surname".to_s, count: 2
  end
end

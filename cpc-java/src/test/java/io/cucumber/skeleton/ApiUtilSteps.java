package io.cucumber.skeleton;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class ApiUtilSteps {
  @Given("I make an API call to {string} with {string}")
  public void i_make_an_API_call_to_with(String string, String string2) {
      // Write code here that turns the phrase above into concrete actions
      throw new cucumber.api.PendingException();
  }

  @Given("the API response code is {string}")
  public void the_API_response_code_is(String string) {
      // Write code here that turns the phrase above into concrete actions
      throw new cucumber.api.PendingException();
  }

  @When("I parse the API response body and write it to {string}")
  public void i_parse_the_API_response_body_and_write_it_to(String string) {
    // Write code here that turns the phrase above into concrete actions
    throw new cucumber.api.PendingException();
  }
}

// Step blocks in Ruby

// Given("I make an API call to {string} with {string}") do |string1, string2|
//   case
//   when string1 == "ISBNdb"
//     isbn_str = string2
//     isbn = Cpc::Toolkit::IsbnFetcher.new('ISBN_DB_API_KEY')
//     @book_details_hsh = isbn.book_details(isbn_str, @box_str)
//   end
// end
//
// Given("the API response code is {string}") do |string|
//   expect(@book_details_hsh[:response_code]).to eq(string)
// end
//
// When("I parse the API response body and write it to {string}") do |string|
//   case string
//   when "ISBN CSV"
//     output_filepath = 'spec/output/isbn_details.csv'
//     csv_obj = Cpc::Util::GenerateDataUtil.csv_from_simple_hsh_with_header(@book_details_hsh)
//     f = File.open(output_filepath, 'w')
//     f.write(csv_obj)
//     f.close
//     @book_details_csv = Cpc::Util::FileParseUtil.parse_csv_file(output_filepath)
//   end
// end

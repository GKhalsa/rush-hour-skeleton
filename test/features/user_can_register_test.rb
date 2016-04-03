require_relative "../test_helper"

class UserCanRegisterTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def test_user_can_register_with_valid_inputs
    post '/sources', {identifier: "Google", rootUrl: "google.com"}

    visit '/sources/Google'
    assert_equal'/sources/Google', current_path

    within ("#message") do
      assert page.has_content?("no payload data has been received for this source")
    end
  end

  def test_user_can_not_register_without_filling_both_fields
    post '/sources', {identifier: "", rootUrl: "google.com"}
    visit '/sources/Google'
    assert_equal'/sources/Google', current_path

    within ("#message") do
      assert page.has_content?("Client does not exist")
    end

    post '/sources', {identifier: "Google", rootUrl: ""}

    visit '/sources/Google'
    assert_equal'/sources/Google', current_path

    within ("#message") do
      assert page.has_content?("Client does not exist")
    end
  end
end

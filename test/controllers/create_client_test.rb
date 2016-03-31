require_relative "../test_helper"

class CreateClientTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def app
    RushHour::Server
  end

  def test_it_creates_a_client_with_valid_attributes
    assert_equal 0, Client.count

    post '/sources', { client: {identifier: "Turing", root_url: "https://www.turing.io/"}}

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "Turing:https://www.turing.io/", last_response.body
  end

  def test_it_does_not_create_a_client_with_parameters_missing
    assert_equal 0, Client.count

    post '/sources', { client: {}}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank, Root_url can't be blank",
    last_response.body

    post '/sources', { client: {identifier: "Turing", root_url: ""}}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root_url can't be blank", last_response.body

    post '/sources', { client: {identifier: "", root_url: "https://www.turing.io/"}}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_it_does_not_create_a_client_without_a_unique_identifier
    assert_equal 0, Client.count

    post '/sources', { client: {identifier: "Turing", root_url: "https://www.turing.io/"}}

    assert_equal 1, Client.count

    post '/sources', { client: {identifier: "Turing", root_url: "https://www.turing.io/"}}

    assert_equal 1, Client.count
    assert_equal 403, last_response.status

    assert_equal "Turing has already been taken", last_response.body

    post '/sources', { client: {identifier: "Lorax", root_url: "https://www.turing.io/"}}

    assert_equal 2, Client.count
    assert_equal 200, last_response.status
    assert_equal "Lorax:https://www.turing.io/", last_response.body

  end

end

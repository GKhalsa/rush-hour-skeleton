require_relative '../test_helper'
require 'pry'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_name
    request_type = RequestType.create({:name => "GET"})
    assert_equal "GET", request_type.name
  end

  def test_is_invalid_with_missing_name
    request_type = RequestType.create(name: "")
    refute request_type.valid?
  end

  def test_it_can_return_the_most_frequent_request_type
    create_payloads(3)
    PayloadRequest.last.request_type.update(name: "PUT")

    assert_equal "GET", RequestType.most_frequent
  end

  def test_it_can_return_all_of_the_http_verbs_used
    create_payloads(3)
    PayloadRequest.last.request_type.update(name: "PUT")

    assert_equal ["GET","PUT"], RequestType.all_verbs
  end
end

require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_event_type
    event_type = EventType.create({:name => "http://www.google.com"})
    assert_equal "http://www.google.com", event_type.name
  end

  def test_is_invalid_with_missing_event_type
    event_type = EventType.create(name: "")
    refute event_type.valid?
  end

  def test_can_rank_event_by_frequency
    create_payloads(3)
    PayloadRequest.last.event_type.update(name: "socialLogin1")

    assert_equal ["socialLogin1", "socialLogin2"], EventType.rank_events
  end

  def test_it_can_find_a_event_type_by_hour
    create_payloads(3)

    event    = EventType.find_by(name: "socialLogin1")
    expected = {4.0 => 1}
    assert_equal expected, event.event_type_by_hours
  end
end

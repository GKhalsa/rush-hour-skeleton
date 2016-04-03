class EventBuilder
  attr_reader :event_message,
              :event_per_hour,
              :current_page,
              :event_type

  def initialize(identifier, event_name)
    client          = Client.where(identifier: identifier).first
    @event_type      = EventType.find_or_create_by(name: event_name)
    @event_message  = message(event_type)
    @event_per_hour = @event_type.by_hours
    @current_page   = "#{event_name}"
  end

  def message(event)
    if event.payload_requests == []
      "This event hasn't been requested"
    else
      "your event is kicking ass"
    end
  end

end

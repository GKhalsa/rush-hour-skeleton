module ResponseTimes

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def max_response_time
    payload_requests.maximum(:responded_in).to_f
  end

  def min_response_time
    payload_requests.minimum(:responded_in).to_f
  end

  def ordered_response_times
    array_formatter(payload_requests.order(responded_in: :desc).pluck(:responded_in).to_a)
  end
end

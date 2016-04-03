class Client < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :rootUrl, presence: true
  has_many :payload_requests

  has_many :request_types, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :user_agents, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :event_types, through: :payload_requests

  def most_frequent_verbs
    request_types.group(:name).count.map do |key, value|
      "#{key} => #{value}"
    end.join(", ")

  end

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def max_response_time
    payload_requests.maximum(:responded_in).to_f
  end

  def min_response_time
    payload_requests.minimum(:responded_in).to_f
  end

  def all_verbs
    request_types.pluck(:name).uniq
  end

  def url_breakdown
    urls.group(:address).count.sort_by { |k,v| v }.reverse
  end

  def browser_breakdown
    user_agents.group(:browser).count
  end

  def os_breakdown
    user_agents.group(:os).count
  end

  def screen_resolution_breakdown
    resolutions.group(:width,:height).count
  end

end

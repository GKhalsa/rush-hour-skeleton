require_relative "response_times"

class Client < ActiveRecord::Base
  include ResponseTimes

  validates :identifier, presence: true, uniqueness: true
  validates :rootUrl, presence: true
  has_many :payload_requests

  has_many :request_types, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :user_agents, through: :payload_requests
  has_many :resolutions, through: :payload_requests
  has_many :event_types, through: :payload_requests

  def most_frequent_verbs
    hash_formatter(request_types.group(:name).count)
  end

  def all_verbs
    request_types.pluck(:name).uniq
  end

  def url_breakdown
    urls.group(:address).count.sort_by { |k,v| v }.reverse
  end

  def browser_breakdown
    hash_formatter(user_agents.group(:browser).count)
  end

  def os_breakdown
    hash_formatter(user_agents.group(:os).count)
  end

  def screen_resolution_breakdown
    resolution_formatter(resolutions.group(:width,:height).count)
  end

  def resolution_formatter(hash)
    hash.map do |key, value|
      resolution = key.join(" X ")
      "#{resolution} => #{value}"
    end.join(", ")
  end

  def hash_formatter(hash)
    hash.map do |key, value|
      "#{key} => #{value}"
    end.join(", ")
  end
end

require 'pry'
class Url < ActiveRecord::Base
  validates :address, presence: true
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :user_agents, through: :payload_requests

  def max_response_time
    payload_requests.maximum(:responded_in).to_f
  end

  def min_response_time
    payload_requests.minimum(:responded_in).to_f
  end

  def ordered_response_times
    array_formatter(payload_requests.order(responded_in: :desc).pluck(:responded_in).to_a)
  end

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def verbs
    array_formatter(request_types.pluck(:name).uniq)
  end

  def best_referrers
    array_formatter(referrers.order(address: :desc).pluck(:address).uniq.take(3))
  end

  def best_user_agents
    array_formatter(user_agents.order(browser: :desc, os: :desc).pluck(:browser, :os).uniq.take(3))
  end

  def self.ranked
    uniq.group('urls.id').order(:address).pluck(:address)
  end

  def array_formatter(passed_array)
    passed_array.join(", ")
  end
end

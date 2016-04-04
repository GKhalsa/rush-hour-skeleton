require_relative "response_times"

class Url < ActiveRecord::Base
  include ResponseTimes

  validates :address, presence: true
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :user_agents, through: :payload_requests

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

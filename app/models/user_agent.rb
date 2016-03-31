class UserAgent < ActiveRecord::Base
  validates :browser, presence: true
  validates :os,      presence: true
  has_many :payload_requests

  def self.browser_breakdown
    user_agents = PayloadRequest.group(:user_agent).count
    user_agents.reduce(Hash.new(0)) do |new_hash, v|
      new_hash[v[0].browser] += v[1]
      new_hash
    end
  end

  def self.os_breakdown
    user_agents = PayloadRequest.group(:user_agent).count
    user_agents.reduce(Hash.new(0)) do |new_hash, v|
      new_hash[v[0].os] += v[1]
      new_hash
    end
  end
end

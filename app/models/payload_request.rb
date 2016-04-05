class PayloadRequest < ActiveRecord::Base
  validates  :url_id,          presence: true
  validates  :requested_at,    presence: true
  validates  :responded_in,    presence: true
  validates  :referrer_id,     presence: true
  validates  :request_type_id, presence: true
  validates  :event_type_id,   presence: true
  validates  :user_agent_id,   presence: true
  validates  :resolution_id,   presence: true
  validates  :ip,              presence: true
  validates  :sha,             presence: true, uniqueness: true

  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :user_agent
  belongs_to :event_type
  belongs_to :client

  def self.average_response_time
    average(:responded_in)
  end

  def self.max_response_time
    maximum(:responded_in)
  end

  def self.min_response_time
    minimum(:responded_in)
  end
end

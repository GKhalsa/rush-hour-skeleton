class EventType < ActiveRecord::Base
  validates :name, presence: true
  has_many :payload_requests

  def self.rank_events
    uniq.group('event_types.id').order(:name).pluck(:name)
  end

  def total
    payload_requests.count
  end

  def by_hours
    payload_requests.group("DATE_PART('hour',requested_at)").count
  end


end

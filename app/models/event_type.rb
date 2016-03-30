class EventType < ActiveRecord::Base
  validates :name, presence: true
  has_many :payload_requests

  def self.rank_events
    uniq.group('event_types.id').order(:name).pluck(:name)
  end
end

class EventType < ActiveRecord::Base
  validates :name, presence: true
  has_many :payload_request
end

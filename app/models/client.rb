class Client < ActiveRecord::Base
  validates :root_url, presence: true
  has_many :payload_requests
end

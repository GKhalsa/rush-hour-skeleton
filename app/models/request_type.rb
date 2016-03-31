class RequestType < ActiveRecord::Base
  validates :name, presence: true
  has_many :payload_requests

  def self.most_frequent
    all.max_by do |verb|
      verb.payload_requests.count
    end.name
  end

  def self.all_verbs
    uniq.pluck(:name)
  end
end

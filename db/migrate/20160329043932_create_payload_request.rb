class CreatePayloadRequest < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.text :url #are these active record methods or postgres?
      t.timestamp :requested_at #timestamp [ (p) ] with time zone
      t.integer  :responded_in
      t.text :referred_by
      t.text :request_type
      t.text  :parameters #needs to store an array of the params in a post or put request?
      t.text :event_name
      t.text :user_agent
      t.integer :resolution_width #maybe this and the next come in as strings?
      t.integer :resolution_height #might have to convert them before putting them in the table if we want to do calculations
      t.inet :ip #The inet type holds an IPv4 or IPv6 host address, and optionally its subnet, all in one field. The subnet is represented by the number of network address bits present in the host address (the "netmask"). If the netmask is 32 and the address is IPv4, then the value does not indicate a subnet, only a single host. In IPv6, the address length is 128 bits, so 128 bits specify a unique host address. Note that if you want to accept only networks, you should use the cidr type rather than inet.

      t.timestamps null: false    end
  end
end

# payload = {
#   "url":"http://jumpstartlab.com/blog",
#   "requestedAt":"2013-02-16 21:38:28 -0700",
#   "respondedIn":37,
#   "referredBy":"http://jumpstartlab.com",
#   "requestType":"GET",
#   "parameters":[],
#   "eventName": "socialLogin",
#   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1920",
#   "resolutionHeight":"1280",
#   "ip":"63.29.38.211"
# }

# def change
#     create_table :films do |t|
#       t.text     :title
#       t.date     :year
#       t.integer  :box_office_sales
#
#       t.timestamps null: false
#     end
#   end

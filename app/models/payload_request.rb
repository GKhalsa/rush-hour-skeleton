class PayloadRequest < ActiveRecord::Base
            validates  :url,               presence: true
            # validates  :url_id,               presence: true
            validates  :requested_at,      presence: true
            validates  :responded_in,      presence: true
            validates  :referred_by,       presence: true
            validates  :request_type,      presence: true
            validates  :parameters,        presence: true
            validates  :event_name,        presence: true
            validates  :user_agent,        presence: true
            validates  :resolution_width,  presence: true
            validates  :resolution_height, presence: true
            validates  :ip,                presence: true
end

# def change
#   create_table :payload_requests do |t|
#     t.text :url #are these active record methods or postgres?
#     t.date :requested_at #don't think it will be date tho....
#     t.integer  :responded_in
#     t.text :referred_by
#     t.text :request_type
#     t.???  :parameters #needs to store an array of the params in a post or put request?
#     t.text :event_name
#     t.text :user_agent
#     t.integer :resolution_width #maybe this and the next come in as strings?
#     t.integer :resolution_height #might have to convert them before putting them in the table if we want to do calculations
#     t.ip :ip #just have a feeling this might be supported...
#   end
# end

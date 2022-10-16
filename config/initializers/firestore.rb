require "google/cloud/firestore"

Google::Cloud::Firestore.configure do |config|
  config.project_id = "cb-morning"
end

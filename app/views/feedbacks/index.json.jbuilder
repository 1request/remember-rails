json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :name, :device_type, :device_id, :created_at, :updated_at
  json.audio_url feedback.audio
end

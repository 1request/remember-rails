json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :name, :audio_url, :device_type, :device_id
end

json.array!(@audios) do |audio|
  json.extract! audio, :id, :group_id, :user_id, :audioclip
  json.url audio_url(audio, format: :json)
end

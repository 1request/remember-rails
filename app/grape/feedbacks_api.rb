module Remember
 class FeedbackApi < Grape::API

    content_type :json, "application/json;charset=UTF-8"
    format :json

    prefix "api"

    resource :feedbacks do
      # /api/feedbacks/send
      post 'send' do
        if params[:audio]
          audio = params[:audio]
          attachment = {
            :filename => audio[:filename],
            :type => audio[:type],
            :headers => audio[:head],
            :tempfile => audio[:tempfile]
          }
          Feedback.create(
            name: params[:name],
            device_id: params[:deviceId],
            device_type: params[:deviceType],
            audio: ActionDispatch::Http::UploadedFile.new(attachment)
          )

          present :ok, true
        end
      end
    end
 end
end

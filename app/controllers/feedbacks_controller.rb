class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.order(created_at: :desc)
  end
end

class ArticlesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "articles:new"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

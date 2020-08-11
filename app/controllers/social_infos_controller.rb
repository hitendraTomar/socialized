class SocialInfosController < ApplicationController

  def my_social_world
    request_handler = RequestHandlerService.call
    render json: request_handler.result
  end
end

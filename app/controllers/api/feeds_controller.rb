module Api
  class FeedsController < ApplicationController
    protect_from_forgery with: :null_session # These are REST API endpoints

    def index
      render json: Feed.all
    end
  end
end

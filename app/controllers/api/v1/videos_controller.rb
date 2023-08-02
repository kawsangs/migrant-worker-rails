# frozen_string_literal: true

module Api
  module V1
    class VideosController < ApplicationController
      def index
        pagy, videos = pagy(Video.includes(:video_author))

        render json: {
          pagy: pagy.vars,
          videos: ActiveModel::Serializer::CollectionSerializer.new(videos, serializer: VideoSerializer)
        }
      end
    end
  end
end

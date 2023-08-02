# frozen_string_literal: true

class VideoTagsController < ApplicationController
  include TaggableControllerConcern

  private
    def query_tags
      authorize Video.tag_counts(filter_params).includes(:videos)
    end

    def redirect_url
      video_tags_url
    end
end

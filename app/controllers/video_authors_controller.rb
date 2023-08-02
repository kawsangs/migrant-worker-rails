# frozen_string_literal: true

class VideoAuthorsController < ApplicationController
  helper_method :filter_params
  before_action :set_video_author, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        @pagy, @video_authors = pagy(query_video_authors)
      }

      format.json {
        @video_authors = query_video_authors

        if @video_authors.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to video_authors_url
        else
          render json: @video_authors
        end
      }
    end
  end

  def edit
  end

  def update
    if @video_author.update(video_author_params)
      redirect_to video_authors_url
    else
      render :edit
    end
  end

  def destroy
    if @video_author.destroy
      redirect_to video_authors_url
    else
      redirect_to video_authors_url, alert: @video_author.errors.full_messages.join(", ")
    end
  end

  private
    def filter_params
      params.permit(:name)
    end

    def video_author_params
      params.require(:video_author).permit(:name)
    end

    def set_video_author
      @video_author = authorize VideoAuthor.find(params[:id])
    end

    def query_video_authors
      authorize VideoAuthor.filter(filter_params).order(display_order: :asc, created_at: :desc)
    end
end

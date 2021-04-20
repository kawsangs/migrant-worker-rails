# frozen_string_literal: true

class MigrantsController < ApplicationController
  def index
    @pagy, @migrants = pagy(policy_scope(authorize Migrant.filter(params).newest))
  end

  def download
    migrants = policy_scope(authorize Migrant.filter(params))

    if migrants.length > ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i
      flash[:alert] = t("migrants.file_size_is_too_big")
      redirect_to migrants_url
    else
      send_data(::MigrantService.new(migrants).export_csv, filename: "migrants.csv")
    end
  end

  def voice
    migrant = authorize Migrant.find(params[:id])

    send_file migrant.voice_url
  end
end

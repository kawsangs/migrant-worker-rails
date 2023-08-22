# frozen_string_literal: true

module Api
  module V2
    class PdfsController < ApiController
      def download
        send_file(
          "#{Rails.root}/public/pdfs/#{params[:filename]}",
          filename: "#{params[:filename]}",
          type: "application/pdf"
        )
      end
    end
  end
end

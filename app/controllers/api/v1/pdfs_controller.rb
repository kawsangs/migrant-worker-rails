# frozen_string_literal: true

module Api
  module V1
    class PdfsController < ::Api::V1::ApplicationController
      def download
        send_file(
          "#{Rails.root}/public/pdfs/#{params[:filename]}",
          filename: "#{params[:filename]}",
          type: 'application/pdf'
        )
      end
    end
  end
end

# frozen_string_literal: true

class AboutsController < ApplicationController
  skip_before_action :authenticate_account!
  layout :set_layout

  def show
  end

  private
    def set_layout
      signed_in? ? "layouts/application" : "layouts/sidebar-less"
    end
end

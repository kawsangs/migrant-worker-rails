# frozen_string_literal: true

class ChatGroupsController < ApplicationController
  def index
    @pagy, @chat_groups = pagy(authorize ChatGroup.includes(:telegram_bot))
  end
end

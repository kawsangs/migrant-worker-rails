# frozen_string_literal: true

require "sidekiq-scheduler"

class CategoryImageJob
  include Sidekiq::Job

  def perform(*args)
    CategoryImage.where(category_id: nil).destroy_all
  end
end

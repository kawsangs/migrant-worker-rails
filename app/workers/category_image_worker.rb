require 'sidekiq-scheduler'

class CategoryImageWorker
  include Sidekiq::Worker

  def perform(*args)
    CategoryImage.where(category_id: nil).destroy_all
  end
end

# frozen_string_literal: true

module Categories
  class DepartureJsonBuilder
    attr_accessor :category

    def initialize(category)
      @category = category
    end

    def build
      data = JSON.parse(ActiveModelSerializers::SerializableResource.new(category, { fields: ["id", "name", "description", "image_url", "audio_url", "parent_id", "uuid", "last", "leaf", "lft", "rgt", "type", "is_video", "hint", "hint_audio_url", "hint_image_url"] }).to_json)
      assign_category_assets(data)
      data
    end

    private
      def assign_category_assets(cate)
        cate["image"] = "require('../../assets/images/category/#{cate["image_url"].split('/').last}')" if cate["image_url"].present?
        cate["audio"] = cate["audio_url"].split("/").last if cate["audio_url"].present?
        cate["hint_image"] = "require('../../assets/images/category/#{cate["hint_image_url"].split('/').last}')" if cate["hint_image_url"].present?
        cate["hint_audio"] = cate["hint_audio_url"].split("/").last if cate["hint_audio_url"].present?
        cate["offline"] = true
      end
  end
end

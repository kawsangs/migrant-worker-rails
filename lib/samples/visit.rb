# frozen_string_literal: true

require_relative "base"

module Samples
  class Visit < Samples::Base
    def simulate_visit_notification(count = 1)
      count.times.each do |i|
        pages = [
          { code: "open_remote_notification", name: "Open remote notification", parent_code: "" },
          { code: "open_in_app_notification", name: "Open in-app notification", parent_code: "" }
        ]

        click_on_page_detail(NotificationOccurrence.all.sample, pages.sample)
      end
    end

    def simulate_visit_category(count = 1)
      pages = [
        { name: "ដំណើរឆ្លងដែនរបស់អ្នក", code: "your_departure" },
        { name: "សុវត្ថិភាពរបស់អ្នក", code: "your_safety" },
        { name: "ស្វែងរកជំនួយ", code: "find_help" },
        { name: "សាច់រឿងរបស់អ្នក", code: "your_story" },
        { name: "វីដេអូ", code: "video" },
      ]

      count.times.each do |i|
        click_on_main_page({ name: "បើកអ៊ែប", code: "app_visit" })
        click_on_main_page(pages.sample)
      end
    end

    def simulate_video(count = 1)
      click_on_main_page({ code: "video", name: "វីដេអូមុខរបរ" })

      count.times.each do |i|
        click_on_page_detail(Video.all.sample, {
          code: "video_detail",
          name: "video detail",
          parent_code: "video"
        })
      end
    end

    private
      def click_on_page_detail(pageable, page_attributes = {})
        ::Visit.create(
          user_uuid: user_uuid,
          visit_date: rand(1..100).days.ago,
          pageable: pageable,
          page_attributes: page_attributes,
        )
      end

      def click_on_main_page(page_attributes = {})
        ::Visit.create(
          user_uuid: user_uuid,
          visit_date: rand(1..100).days.ago,
          page_attributes: page_attributes,
        )
      end

      def user_uuid
        ::User.all.sample.uuid
      end
  end
end

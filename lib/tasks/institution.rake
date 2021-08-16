# frozen_string_literal: true

namespace :institution do
  desc "migrate display_order"
  task migrate_display_order: :environment do
    Institution.find_each do |institution|
      institution.update(display_order: institution.class.maximum(:display_order).to_i + 1)
    end
  end
end

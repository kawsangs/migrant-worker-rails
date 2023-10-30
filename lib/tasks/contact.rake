# frozen_string_literal: true

namespace :contact do
  desc "migrate type to have Contacts module"
  task migrate_type_to_have_contacts_module: :environment do
    Contact.inheritance_column = :_type_disabled
    Contact.all.find_each do |contact|
      type = "Contacts::#{contact.type.to_s.split("::").last}"

      contact.update_column(:type, type)
    end
  end
end

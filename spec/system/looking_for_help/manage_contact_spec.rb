require 'rails_helper'

RSpec.describe 'Manage contact', type: :system do
  let(:account) { create(:account) }
  let!(:contact) { create(:contact) }

  before do
    driven_by(:rack_test)
    sign_in account
  end

  describe '#create' do
    it 'enables to create new contact' do
      visit '/contacts'

      phone_number = '098374634'

      click_on 'new contact'
      select(contact.country.name, from: 'Country')
      select(contact.help_center.name, from: 'Help center')
      fill_in('Phones', with: phone_number)

      click_on 'save'

      expect(page).to have_current_path(contacts_path)
      expect(page).to have_content(contact.country.name)
      expect(page).to have_content(contact.help_center.name)
      expect(page).to have_content(phone_number)
    end
  end

  xdescribe '#edit' do
    it 'enables to update existing help_center name' do
      visit '/help_centers'

      click_link "edit_help_center_#{help_center.id}"
      fill_in 'Name', with: 'child help service'
      click_button 'save'

      expect(page).to have_content('child help service')
    end
  end

  xdescribe '#destroy' do
    it 'enables to delete existing help_center by name' do
      visit '/help_centers'

      click_link "delete_help_center_#{help_center.id}"

      expect(page).to have_content('success')
    end
  end
end

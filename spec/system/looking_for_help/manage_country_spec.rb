require 'rails_helper'

RSpec.describe 'Manage country', type: :system do
  let(:account) { create(:account) }
  let!(:country) { create(:country) }

  before do
    driven_by(:rack_test)
    sign_in account
  end

  describe '#create' do
    it 'enables to create new country' do
      visit '/countries'

      click_on 'new country'
      fill_in 'Name', with: 'usa'
      click_on 'save'

      expect(page).to have_current_path(countries_path)
      expect(page).to have_content('usa')
    end
  end

  describe '#edit' do
    it 'enables to update existing country name' do
      visit '/countries'

      click_link "edit_country_#{country.id}"
      fill_in 'Name', with: 'China'
      click_button 'save'

      expect(page).to have_content('China')
    end
  end

  describe '#destroy' do
    it 'enables to delete existing country by name' do
      visit '/countries'

      click_link "delete_country_#{country.id}"

      expect(page).to have_content('success')
    end
  end

  it 'enables to create contacts for help centers'
end

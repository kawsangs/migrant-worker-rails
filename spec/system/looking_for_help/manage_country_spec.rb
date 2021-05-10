require 'rails_helper'

RSpec.describe 'Manage country', type: :system do
  let(:account) { create(:account) }

  before do
    driven_by(:rack_test)
    sign_in account
  end

  it '#create' do
    visit '/countries'

    click_on 'new country'
    fill_in 'Name', with: 'cambodia'
    click_on 'save'

    expect(page).to have_current_path(countries_path)
    expect(page).to have_content('cambodia')
  end

  describe '#edit' do
    let!(:country) { create(:country) }

    it 'enables to update existing country name' do
      visit '/countries'

      click_link "country_#{country.id}"
      fill_in 'Name', with: 'China'
      click_button 'save'

      expect(page).to have_content('China')
    end
  end
  
  it 'enables to create help centers'
  it 'enables to create contacts for help centers'
end

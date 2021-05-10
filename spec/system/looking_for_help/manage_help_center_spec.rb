require 'rails_helper'

RSpec.describe 'Manage help center', type: :system do
  let(:account) { create(:account) }
  let!(:help_center) { create(:help_center) }

  before do
    driven_by(:rack_test)
    sign_in account
  end

  describe '#create' do
    it 'enables to create new help_center' do
      visit '/help_centers'

      click_on 'new center'
      fill_in 'Name', with: 'child help hotline'
      click_on 'save'

      expect(page).to have_current_path(help_centers_path)
      expect(page).to have_content('child help hotline')
    end
  end

  describe '#edit' do
    it 'enables to update existing help_center name' do
      visit '/help_centers'

      click_link "edit_help_center_#{help_center.id}"
      fill_in 'Name', with: 'child help service'
      click_button 'save'

      expect(page).to have_content('child help service')
    end
  end

  describe '#destroy' do
    it 'enables to delete existing help_center by name' do
      visit '/help_centers'

      click_link "delete_help_center_#{help_center.id}"

      expect(page).to have_content('success')
    end
  end
  
  it 'enables to create contacts for help centers'
end

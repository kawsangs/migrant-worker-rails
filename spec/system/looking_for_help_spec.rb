require 'rails_helper'

RSpec.describe 'Looking for help', type: :system do
  let(:account) { create(:account) }

  before do
    driven_by(:rack_test)
    sign_in account
  end

  it 'enables to create country' do
    visit '/countries'

    click_on 'new country'

    fill_in 'Name', with: 'cambodia'

    click_on 'save'

    expect(page).to have_current_path(countries_path)
    expect(page).to have_content('cambodia')
  end
  
  it 'enables to create help centers'
  it 'enables to create contacts for help centers'
end

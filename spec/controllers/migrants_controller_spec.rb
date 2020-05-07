require 'rails_helper'

RSpec.describe MigrantsController, type: :controller do
  describe "GET #download" do
    let!(:account) { FactoryBot.create(:account) }
    before do
      sign_in account
      FactoryBot.create_list(:migrant, 3)
    end

    context 'over limit' do
      before do
        ENV["MAXIMUM_DOWNLOAD_RECORDS"] = '2'
        get :download
      end

      it { expect(response.status).to eq(302) }
      it { expect(flash[:alert]).to eq(I18n.t('migrants.file_size_is_too_big')) }
    end

    context 'under limit' do
      before do
        ENV["MAXIMUM_DOWNLOAD_RECORDS"] = '4'
        get :download
      end

      it { expect(response.status).to eq(200) }
    end
  end
end

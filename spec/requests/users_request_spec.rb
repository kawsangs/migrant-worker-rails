# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #download" do
    let!(:account) { FactoryBot.create(:account) }
    before do
      sign_in account
      FactoryBot.create_list(:user, 3)
    end

    context "over limit" do
      before do
        Settings = double("Settings")
        allow(Settings).to receive(:max_download_record).and_return(2)

        get :download
      end

      it { expect(response.status).to eq(302) }
      it { expect(flash[:alert]).to eq(I18n.t("shared.file_size_is_too_big", max_record: Settings.max_download_record)) }
    end

    context "under limit" do
      before do
        Settings = double("Settings")
        allow(Settings).to receive(:max_download_record).and_return(4)

        get :download
      end

      it { expect(response.status).to eq(200) }
    end
  end
end

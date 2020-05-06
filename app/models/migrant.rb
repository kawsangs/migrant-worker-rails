class Migrant < ApplicationRecord
  mount_uploader :voice, ::VoiceUploader

  def self.filter(params={})
    scope = all
    scope = scope.where('LOWER(full_name) LIKE ? OR LOWER(phone_number) LIKE ?', "%#{params[:keyword].downcase}%", "%#{params[:keyword].downcase}%") if params[:keyword].present?
    scope
  end
end

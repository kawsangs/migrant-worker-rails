class Migrant < ApplicationRecord
  mount_uploader :voice, ::VoiceUploader
end

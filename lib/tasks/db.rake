# frozen_string_literal: true

namespace :db do
  desc "prepare to run the test"
  task prepare_for_test: :environment do
    sh "rake db:drop RAILS_ENV=test"
    sh "rake db:create RAILS_ENV=test"
    sh "rake db:schema:load RAILS_ENV=test"
  end

  desc "prepare for new db environment"
  task dev: :environment do
    sh "rake db:drop"
    sh "rake db:create"
    sh "rake db:migrate"
    sh "rake sample:load"
  end
end

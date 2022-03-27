namespace :heroku do
  desc 'basically export the measurement table to a csv in S3 for the frontend team'

  task export_recently_measurements_to_s3: :environment do
    Rails.logger.info 'start export'

    Instrument::Measurements::ExportCsv.new.perform

    Rails.logger.info 'ends export'
  end
end

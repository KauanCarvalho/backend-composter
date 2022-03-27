# frozen_string_literal: true

require 'csv'

module Instrument
  module Measurements
    class ExportCsv
      def initialize; end

      def perform
        return if there_is_a_daily_file?
        return if there_is_no_record?

        @temp_file = Tempfile.new([Date.current.to_s, '.csv'])

        CSV.open(temp_file, 'w', write_headers: true, headers: headers) do |csv|
          ::Instrument::Measurement.find_in_batches(batch_size: 100) do |group|
            # Take each measurement by batch.
            group.each do |measurement|
              csv << [
                measurement.id,
                measurement.quality,
                measurement.value,
                measurement.measured_at.strftime('%d/%m/%y %H:%M:%S'),
                measurement.created_at.strftime('%d/%m/%y %H:%M:%S'),
                measurement.updated_at.strftime('%d/%m/%y %H:%M:%S')
              ]
            end
          end
        end

        create_registry!
      end

      private

      attr_reader :temp_file

      def headers
        %w[uuid quality value measured_at created_at updated_at]
      end

      def name_based_on_date
        [Date.current.to_s, '.csv'].join
      end

      # For now we will only perform the dump of this table.
      def table_name
        ::Instrument::Measurement.table_name
      end

      # Validates if we have already created today's record.
      def there_is_a_daily_file?
        TableExport.created_today.exists?(related_table: table_name)
      end

      # Validates if there is no record.
      def there_is_no_record?
        !::Instrument::Measurement.eligible_for_chart.exists?
      end

      # Create the bank record and attach the file to the s3.
      def create_registry!
        TableExport.create!(related_table: table_name).tap do |table_export|
          table_export.csv_file.attach(io: temp_file, filename: name_based_on_date, content_type: 'csv')
        end
      end
    end
  end
end

class CreateInstrumentMeasurements < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_measurements, id: :uuid do |t|
      t.datetime :measured_at, null: false
      t.string :quality,       null: false
      t.float :value,          null: false 

      t.timestamps
    end
  end
end

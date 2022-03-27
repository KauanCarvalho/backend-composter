class CreateTableExports < ActiveRecord::Migration[6.0]
  def change
    create_table :table_exports, id: :uuid do |t|
      t.string :related_table, null: false

      t.timestamps
    end
  end
end

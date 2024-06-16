class CreateBreakReasons < ActiveRecord::Migration[7.0]
  def change
    create_table :break_reasons do |t|
      t.references :users, null: false, foreign_key: true
      t.string :reason, null: false

      t.timestamps
    end
  end
end

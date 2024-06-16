class CreateBreakReasonAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :break_reason_associations do |t|
      t.references :break_reason, null: false, foreign_key: true
      t.references :break_reason_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end

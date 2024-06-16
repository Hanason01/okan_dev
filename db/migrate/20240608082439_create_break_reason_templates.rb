class CreateBreakReasonTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :break_reason_templates do |t|
      t.references :user, null: false, foreign_key: true
      t.string :template_name

      t.timestamps
    end
  end
end

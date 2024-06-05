class CreatePomodoroSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :pomodoro_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :minutes, null: false
      t.integer :set_count, null: false
      t.string :set_title, null: false

      t.timestamps
    end
  end
end

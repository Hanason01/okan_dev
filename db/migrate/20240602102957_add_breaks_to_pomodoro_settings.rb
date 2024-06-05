class AddBreaksToPomodoroSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :pomodoro_settings, :breaks, :integer, null: false
  end
end

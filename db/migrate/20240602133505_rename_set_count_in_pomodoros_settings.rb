class RenameSetCountInPomodorosSettings < ActiveRecord::Migration[7.0]
  def change
    rename_column :pomodoro_settings, :set_count, :total_sets
  end
end

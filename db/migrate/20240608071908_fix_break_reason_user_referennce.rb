class FixBreakReasonUserReferennce < ActiveRecord::Migration[7.0]
  def change
    remove_reference :break_reasons, :users, foreign_key: true
    add_reference :break_reasons, :user, null: false, foreign_key: true
  end
end

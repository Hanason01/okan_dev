class AddIndexToBreakReasonAssociation < ActiveRecord::Migration[7.0]
  def change
    add_index :break_reason_associations, [:break_reason_id, :break_reason_template_id], unique: true, name: 'index_on_break_reason_association_uniqueness'
  end
end

class AddReferenceForTemplateIntoBreakReason < ActiveRecord::Migration[7.0]
  def change
    add_reference :break_reasons, :break_reason_templates, foreign_key: true
  end
end

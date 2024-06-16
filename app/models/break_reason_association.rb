class BreakReasonAssociation < ApplicationRecord
  belongs_to :break_reason
  belongs_to :break_reason_template

  # validates :break_reason_template_id, presence: true
  # validates :break_reason_id, presence: true
  # validates :break_reason_id, uniqueness: { scope: :break_reason_template_id }

end

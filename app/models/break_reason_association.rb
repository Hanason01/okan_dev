class BreakReasonAssociation < ApplicationRecord
  belongs_to :break_reason
  belongs_to :break_reason_template

  after_destroy :check_and_destroy_template

  private

  def check_and_destroy_template
    if break_reason_template.break_reasons.empty?
      break_reason_template.destroy
    end
  end
end

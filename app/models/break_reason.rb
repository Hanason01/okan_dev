class BreakReason < ApplicationRecord
  belongs_to :user
  has_many :break_reason_associations,dependent: :destroy
  has_many :break_reason_templates, through: :break_reason_associations
  validates :user_id, presence: true
  validates :reason, presence: true, length: {maximum: 10}
  validate :break_limit,if: -> { user.break_reasons.present? }

  private

  def break_limit
    if user.break_reasons.count >= 50
      errors.add(:base, '離席理由は50個までしか作成できません')
    end
  end
end

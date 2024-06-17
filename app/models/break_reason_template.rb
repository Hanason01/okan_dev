class BreakReasonTemplate < ApplicationRecord
  belongs_to :user
  has_many :break_reason_associations, dependent: :destroy
  has_many :break_reasons, through: :break_reason_associations
  validates :user_id, presence: true
  validates :template_name, presence: true, length: { maximum: 15 }
  validate :template_limit, if: -> { user.break_reason_templates.present? }
  validate :must_have_at_least_one_break_reason

  private

  def template_limit
    if user.break_reason_templates.count >= 50
      errors.add(:base, '離席理由テンプレートは50個までしか作成できません')
    end
  end

  def must_have_at_least_one_break_reason
    if break_reason_ids.reject(&:blank?).empty?
      errors.add(:base, '少なくとも1つの離席理由を選択してください')
    end
  end
end

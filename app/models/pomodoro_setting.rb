class PomodoroSetting < ApplicationRecord
  belongs_to :user
  validates :minutes, :total_sets, :set_title, :breaks, presence: true
  validates :minutes, :breaks, numericality: {only_integer: true, less_than_or_equal_to:1000, grater_than_or_equal_to:1 }
  validates :total_sets, numericality: {only_integer: true, less_than_or_equal_to:100, grater_than_or_equal_to:1 }
  validates :set_title, length:{maximum: 15 }
  validate :pomodoro_limit, if: -> { user.pomodoro_settings.present? }

private

  def pomodoro_limit
    if user.pomodoro_settings.count >= 50
      errors.add(:base, 'ポモドーロは50個までしか作成できません')
    end
  end

end

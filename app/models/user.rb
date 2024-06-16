class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :pomodoro_settings, dependent: :destroy
  has_many :break_reasons, dependent: :destroy
  has_many :break_reason_templates, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 10 }
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Sorceryのユーザー作成方法を利用してユーザーを作成
user = User.find_or_create_by!(email: 'allferstyle@yahoo.co.jp') do |user|
  user.password = 'composer' # Sorceryが自動的にハッシュ化します
  user.password_confirmation = 'composer'
  user.name = 'hanamu'
end

# Pomodoro設定を作成
PomodoroSetting.find_or_create_by!(
  user_id: user.id,
  minutes: 25,
  total_sets: 2,
  set_title: "デフォルトポモドーロ",
  breaks: 5
)

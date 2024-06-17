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

# OkanReprimandのインスタンスを追加
OkanReprimand.find_or_create_by!(id: 1, body: "あんた！最後までやらなあかんやんか！")
OkanReprimand.find_or_create_by!(id: 2, body: "もおほんまに、お母さん恥ずかしいわ！")
OkanReprimand.find_or_create_by!(id: 3, body: "余裕ぶっこいてたらアカンで！ほんま！")
OkanReprimand.find_or_create_by!(id: 4, body: "どこ行くんや！まだ終わってへんがな！")
OkanReprimand.find_or_create_by!(id: 5, body: "真面目にしい！お母さんもう先寝るで！")
OkanReprimand.find_or_create_by!(id: 6, body: "根性がなっとらんわ！しゃっきあげたろか！")
OkanReprimand.find_or_create_by!(id: 7, body: "なんやて？シャキッとしいなあんたホンマ！")
OkanReprimand.find_or_create_by!(id: 8, body: "コルァ！集中しな！あんたもう飯抜きや！")
OkanReprimand.find_or_create_by!(id: 9, body: "どこ行くねん！ほなお母さんも帰るわ！")
OkanReprimand.find_or_create_by!(id: 10, body: "これやさかい怠けもんは！ええ加減にし！")
OkanReprimand.find_or_create_by!(id: 11, body: "あんたどないなってん！お母さん悲しいわ！")
OkanReprimand.find_or_create_by!(id: 12, body: "作業中でっしゃろ？そんなんおまへんがな！")

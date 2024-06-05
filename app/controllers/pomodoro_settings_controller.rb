class PomodoroSettingsController < ApplicationController
  skip_before_action :require_login, only: %i[home]
  def home
    @pomodoro_settings = current_user&.pomodoro_settings&.includes(:user)
    # ログイン無→NIl、ログイン＆保有→userを関連させたオブジェクト、ログイン＆保有なし→include無効、空のオブジェクト
    @default_pomodoro = PomodoroSetting.includes(:user).find(1)
  end

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end
end

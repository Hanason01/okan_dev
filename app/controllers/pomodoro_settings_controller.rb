class PomodoroSettingsController < ApplicationController
  before_action :set_pomodoro, only: %i[show edit update destroy]
  before_action :check_owner, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[home]

  def home
    # ポモドーロの保持の有無判定
    if current_user&.pomodoro_settings&.exists?
      @pomodoro_settings = current_user.pomodoro_settings.includes(:user)
    else
      @pomodoro_settings = nil
      @default_pomodoro = PomodoroSetting.includes(:user).find(1)
    end

    if logged_in?
      @user = User.find(current_user.id)
    end

    # テンプレートの保持の有無判定
    if current_user&.break_reason_templates&.exists?
      @break_reason_templates = current_user.break_reason_templates.includes(:break_reasons)
    else
      @break_reason_templates = nil
    end

    # セッションに存在しないポモドーロIDが保持されている場合に削除
    if session[:selected_pomodoro_id]
      if @pomodoro_settings.blank? || !@pomodoro_settings.exists?(session[:selected_pomodoro_id])
        session.delete(:selected_pomodoro_id)
      end
    end

    if session[:selected_template_id]
      if @break_reason_templates.blank? || !@break_reason_templates.exists?(session[:selected_template_id])
        session.delete(:selected_template_id)
      end
    end

    # ポモドーロ、テンプレート選択時の処理（セッションに保持）
    if params[:pomodoro_id]
      session[:selected_pomodoro_id] = params[:pomodoro_id]
      set_selected_pomodoro
    elsif params[:break_reason_template_id]
      session[:selected_template_id] = params[:break_reason_template_id]
      set_selected_template
    end

    # 別のアクションから戻ってきた場合にセッションに保持してある値を利用して変数配置
    set_selected_pomodoro if session[:selected_pomodoro_id] && @pomodoro_settings.present?
    set_selected_template if session[:selected_template_id] && @break_reason_templates.present?

    # デフォルトの叱責表示とJS用の配列
    @random_reprimand = OkanReprimand.order("RANDOM()").first.body
    @reprimands = OkanReprimand.all
  end

  def select_pomodoro
    redirect_to root_path(pomodoro_id: params[:pomodoro_id])
  end

  def select_break_reason_template
    redirect_to root_path(break_reason_template_id: params[:break_reason_template_id])
  end

  def index
    @pomodoro_settings = current_user.pomodoro_settings
  end

  def show; end

  def new
    @pomodoro_setting = PomodoroSetting.new
    @user = User.find(params[:user_id])
  end

  def create
    @pomodoro_setting = PomodoroSetting.new(pomodoro_params.merge(user_id: current_user.id))
    @user = User.find(params[:user_id])
    if @pomodoro_setting.save
      flash[:success] = '登録を完了しました'
      redirect_to user_pomodoro_settings_path(current_user)
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @pomodoro_setting.update(pomodoro_params)
      flash[:success] = '更新されました'
      redirect_to pomodoro_setting_path(@pomodoro_setting)
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @pomodoro_setting.id == 1
      flash.now[:alert] = 'デフォルトのポモドーロは削除できません'
      render :show, status: :unprocessable_entity
    else
      @pomodoro_setting.destroy!
      if session[:selected_pomodoro_id] == @pomodoro_setting.id
        session.delete(:selected_pomodoro_id)
      end
      redirect_to user_pomodoro_settings_path(current_user), success: '削除されました', status: :see_other
    end
  end

  private

  def set_pomodoro
    @pomodoro_setting = PomodoroSetting.find(params[:id])
  end

  def pomodoro_params
    params.require(:pomodoro_setting).permit(:minutes, :total_sets, :set_title, :breaks)
  end

  def check_owner
    return if @pomodoro_setting.user == current_user

    raise ActiveRecord::RecordNotFound
  end

  def set_selected_pomodoro
    @selected_pomodoro = @pomodoro_settings.find(session[:selected_pomodoro_id])
  end

  def set_selected_template
    @selected_template = @break_reason_templates.find(session[:selected_template_id])
  end
end
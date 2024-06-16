class BreakReasonsController < ApplicationController
  before_action :set_break_reason, only: %i[edit update destroy]
  before_action :check_owner, only: %i[edit update destroy]

  def index
    @break_reasons = current_user.break_reasons
  end

  def new
    @break_reason = BreakReason.new
    @user = User.find(params[:user_id])
  end

  def create
    @break_reason = BreakReason.new(break_reason_params.merge(user_id: current_user.id))
    @user = User.find(params[:user_id])
    if @break_reason.save
      flash[:success] = '登録を完了しました'
      redirect_to user_break_reasons_path(current_user)
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @break_reason.id == 1
      flash.now[:alert] = 'デフォルトの離席理由は編集できません'
      render :edit, status: :unprocessable_entity
    else
      if @break_reason.update(break_reason_params)
        flash[:success] = '更新されました'
        redirect_to user_break_reasons_path(current_user)
      else
        flash.now[:danger] = '更新に失敗しました'
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @break_reason.id == 1
      flash.now[:alert] = 'デフォルトの離席理由は削除できません'
      render :edit, status: :unprocessable_entity
    else
      @break_reason.destroy!
      redirect_to user_break_reasons_path(current_user), success: '削除されました', status: :see_other
    end
  end

  private

  def set_break_reason
    @break_reason = BreakReason.find(params[:id])
  end

  def break_reason_params
    params.require(:break_reason).permit(:reason)
  end

  def check_owner
    return if @break_reason.user == current_user

    raise ActiveRecord::RecordNotFound
  end
end

class BreakReasonTemplatesController < ApplicationController
  before_action :set_break_reason_template, only: %i[show edit update destroy]
  before_action :check_owner, only: %i[show edit update destroy]

  def index
    @break_reason_templates = current_user.break_reason_templates.includes(:break_reasons)
  end

  def show; end

  def new
    @break_reason_template = BreakReasonTemplate.new
    @user = User.find(params[:user_id])
    @break_reasons = current_user.break_reasons
  end

  def create
    @break_reasons = current_user.break_reasons
    @break_reason_template = BreakReasonTemplate.new(break_reason_template_params.merge(user_id: current_user.id))
    @user = User.find(params[:user_id])

    if @break_reason_template.save
      # selected_reasons = params[:break_reason_template][:break_reason_ids].reject{|element| element.blank?}
      # selected_reasons.each do |break_reason_id|
      #   BreakReasonAssociation.create(
      #     break_reason_template_id: @break_reason_template,
      #     break_reason_id: break_reason_id
      #   )
      #   end
      flash[:success] = '登録を完了しました'
      redirect_to user_break_reason_templates_path(current_user)
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @break_reasons = current_user.break_reasons
  end

  def update
    @break_reasons = current_user.break_reasons
    if @break_reason_template.id == 1
      flash.now[:alert] = 'デフォルトの離席理由テンプレートは編集できません'
      render :edit, status: :unprocessable_entity
    else
      if @break_reason_template.update(break_reason_template_params)
        # @break_reason_template.break_reason_associations.destroy_all
        # selected_reasons = params[:break_reason_template][:break_reason_ids].reject { |element| element.blank? }
        # selected_reasons.each do |break_reason_id|
        #   BreakReasonAssociation.create(
        #     break_reason_template_id: @break_reason_template,
        #     break_reason_id: break_reason_id
        #   )
        # end
        flash[:success] = '更新されました'
        redirect_to user_break_reason_templates_path(current_user)
      else
        flash.now[:danger] = '更新に失敗しました'
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @break_reason_template.id == 1
      flash.now[:alert] = 'デフォルトの離席理由テンプレートは削除できません'
      render :edit, status: :unprocessable_entity
    else
      @break_reason_template.destroy!
      if session[:selected_template_id] == @break_reason_template.id
        session.delete(:selected_template_id)
      end
      redirect_to user_break_reason_templates_path(current_user), success: '削除されました', status: :see_other
    end
  end

  private

  def set_break_reason_template
    @break_reason_template = BreakReasonTemplate.includes(:user, :break_reasons).find(params[:id])
  end

  def break_reason_template_params
    params.require(:break_reason_template).permit(:template_name, break_reason_ids: [])
  end

  def check_owner
    return if @break_reason_template.user == current_user

    raise ActiveRecord::RecordNotFound
  end
end
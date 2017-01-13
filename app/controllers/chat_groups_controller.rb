class ChatGroupsController < ApplicationController
  before_action :set_chat_group, only: [:edit, :update]

  def index
    @groups = ChatGroup.all
  end

  def new
    @group = ChatGroup.new
  end

  def create
    @group = ChatGroup.new(group_params)
    if @group.save
      redirect_to chat_group_messages_path(@group), notice: 'グループが作成されました'
    else
      render action: :new, object: @group, alert: 'グループが作成されませんでした'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to chat_group_messages_path(@group), notice: 'グループが編集されました'
    else
      render action: :edit, object: @group, alert: 'グループが編集されませんでした'
    end
  end

  private
  def group_params
    params.require(:chat_group).permit(:name, {user_ids: []} )
  end

  def set_chat_group
    @group = ChatGroup.find(params[:id])
  end
end

class MessagesController < ApplicationController
  before_action :set_group, only: %w(index create)
  before_action :set_all_groups, only: %w(index create)

  def index
    @message = Message.new
    @messages = Message.where(chat_group_id: params[:chat_group_id])
    @group = ChatGroup.find(params[:chat_group_id])
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to chat_group_messages_path(@group), notice: 'メッセージが投稿されました'
    else
      redirect_to chat_group_messages_path(@group), alert: 'メッセージが投稿されませんでした'
    end
  end

  private
  def set_group
    @group = ChatGroup.find(params[:chat_group_id])
  end

  def set_all_groups
    @groups = ChatGroup.all
  end

  def message_params
    params.require(:message).permit(:body, :image, :user_id, :chat_group_id)
  end
end

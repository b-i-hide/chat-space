class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]
  def index
    @message = Message.new
    @messages = Message.where(chat_group_id: params[:chat_group_id])
    @groups = ChatGroup.all
    @group = ChatGroup.find(params[:chat_group_id])
  end

  def create
    @message = Message.new(message_params)
    @groups = ChatGroup.all
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

  def message_params
    params.require(:message).permit(:body, :image, :user_id, :chat_group_id)
  end
end

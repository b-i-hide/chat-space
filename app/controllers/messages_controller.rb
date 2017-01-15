class MessagesController < ApplicationController
  before_action :set_group, only: %w(index create)
  before_action :set_all_groups, only: %w(index create)
  before_action :set_messages, only: %w(index create)

  def index
    @message = Message.new
    @group = ChatGroup.find(params[:chat_group_id])
  end

  def create
    @user = current_user
    @message = Message.new(message_params)
    if @message.save
      redirect_to chat_group_messages_path(@group), notice: 'メッセージが投稿されました'
    else
      flash.now[:alert] = 'メッセージが投稿されませんでした'
      render action: :index, object: @message
    end
  end

  private
  def set_group
    @group = ChatGroup.find(params[:chat_group_id])
  end

  def set_all_groups
    @groups = ChatGroup.all
  end

  def set_messages
    @messages = Message.where(chat_group_id: params[:chat_group_id])
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: @user.id, chat_group_id: @group.id)
  end
end

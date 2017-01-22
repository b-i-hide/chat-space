require 'rails_helper'

describe MessagesController do
  describe 'GET #new' do
    let(:user){ create(:user) }
    let(:chat_group){ create(:chat_group, user_ids: [user.id]) }
    context 'with user login' do
      login_user
      context 'with valid attributes' do
        before do
          get :index, params: { chat_group_id: chat_group.id, user_ids: [user.id]}
        end
        it "renders the :index template" do
          expect(response).to render_template :index
        end
        it "must have new message instance" do
          message = build(:message)
          expect(message).to be_a_new(Message)
        end
      end
    end

    context 'without user login' do
      it "redirects to sing_in" do
        get :index, params: { chat_group_id: chat_group.id, user_ids: [user.id]}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:user){ create(:user) }
    let(:chat_group){ create(:chat_group, user_ids: [user.id]) }
    context 'with user login' do
      login_user
      context "with valid attributes" do
        before do
          get :create, params: { chat_group_id: chat_group.id, user_id: user.id, message: { body: 'test' } }
        end
        it "return status 302" do
          expect(response.status).to eq 302
        end

        it "redirect to message index" do
          expect(response).to redirect_to chat_group_messages_path(chat_group)
        end
      end

      context "with invalid attributes" do
        before do
          get :create, params: { chat_group_id: chat_group.id, user_id: user.id, message: { body: nil, image: nil } }
        end

        it "returns status 200" do
          expect(response.status).to eq 200
        end

        it "renders message#index" do
          expect(response).to render_template :index
        end
      end
    end

    context 'without user login' do
      it "redirects to sign_in" do
        post :create, params: { chat_group_id: chat_group.id, user_id: user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

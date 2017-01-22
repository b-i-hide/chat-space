require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    context 'with valid attributes' do
      it "is valid with body " do
        expect(build(:message)).to be_valid
      end
    end

    context 'with invalid attributes' do
      it "is invalid without body and image" do
        message = build(:message, body: '', image: nil)
        message.valid?
        expect(message.errors[:body][0]).to include('メッセージと写真が空です')
      end
    end

    context '#posted_date_format' do
      it "should return defined format" do
        message = create(:message, created_at: '2017-01-15 07:59:37')
        expect(message.posted_date_format).to eq('2017/01/15 07:59:37')
      end
    end
  end
end

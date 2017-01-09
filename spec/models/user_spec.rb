require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'with valid attributes' do
      it "is valid with all attributes" do
        expect(build(:user)).to be_valid
      end
    end

    context 'with invalid attributes' do
      it "is invalid without name" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "is invalid without email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "is invalid to use taken email" do
        user = create(:user, email: 'hoge@hoge.com')
        new_user = build(:user, email: 'hoge@hoge.com')
        new_user.valid?
        expect(new_user.errors[:email]).to include("はすでに存在します")
      end

      it "is invalid without password" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "is invalid to use password less than 6 characters" do
        user = build(:user, password: 00000)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "is invalid if it is differnt from password" do
        user = build(:user, password: 00000000 ,password_confirmation: 11111111)
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end
    end
  end
end

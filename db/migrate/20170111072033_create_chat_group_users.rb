class CreateChatGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_group_users do |t|
      t.references :user, index: true,foreign_key: true
      t.references :chat_group, index: true,foreign_key: true

      t.timestamps
    end
  end
end

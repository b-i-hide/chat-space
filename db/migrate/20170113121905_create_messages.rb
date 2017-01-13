class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :image
      t.references :user, foreign_key: true
      t.references :chat_group, foreign_key: true
      t.timestamps
    end

    add_index :messages, [ :user_id, :chat_group_id ]
  end
end

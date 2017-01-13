class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_group

  (validates :body, presence: true) || (validates :image, presence: true)

  def posted_date_format
    self.created_at.strftime("%Y/%m/%d %X")
  end
end

class Message < ApplicationRecord
  # association
  belongs_to :user
  belongs_to :chat_group

  # validation
  validates :body, body: true
  validates :image, body: true

  def posted_date_format
    self.created_at.strftime("%Y/%m/%d %X")
  end
end

class MessageValidator < ActiveModel::EachValidator
  def validate_each
    if record.body.present?
      validates_presence_of(:body)
    else
      validates_presence_of(:image)
    end
  end
end

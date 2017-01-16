class BodyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute]<< (options[:message] || '投稿出来ませんでした') unless record.body? || record.image?
    # record.errors.add(attribute, 'メッセージが投稿されませんでした') unless record.body? || record.image?
  end
  # TODO コメントアウトは後で削除する
  # def validate(record)
  #   if record.body.blank?
  #     record.errors[:body]<< (options[:message] || 'メッセージを投稿出来ませんでした')
  #     # record.errors[:image]<< (options[:message] || '写真を投稿出来ませんでした')
  #   elsif record.image.blank?
  #     record.errors[:image]<< (options[:message] || '写真を投稿出来ませんでした')
  #   end
  # end
end

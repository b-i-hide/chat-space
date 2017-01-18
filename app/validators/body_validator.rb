class BodyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'メッセージと写真が空です') if record.body.blank? && record.image.blank?
  end
end

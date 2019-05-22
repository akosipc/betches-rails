class PastDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      record.errors.add attribute, (options[:message] || "can't be in the past") if value < DateTime.now.beginning_of_day
    end
  end
end

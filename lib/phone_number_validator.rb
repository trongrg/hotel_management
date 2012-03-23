class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^(\+\s?)?(\d+[\s]?\d+)+$/i
      object.errors.add(attribute, :phone_number, options)
    end
  end
end

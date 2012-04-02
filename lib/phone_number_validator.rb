class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^(\(\d+\)|\+)?(\s|-|\.)?(\d+(\s|-|\.)?\d+)+(\sx\d+)?$/
      object.errors.add(attribute, :phone_number, options)
    end
  end
end
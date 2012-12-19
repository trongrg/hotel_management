class CurrencyInput < Formtastic::Inputs::SelectInput
  def select_html
    collection = Money::Currency::table.values.map { |value| value[:iso_code]}
    builder.select(input_name, collection, input_options, input_html_options)
  end
end

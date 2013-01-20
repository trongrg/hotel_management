class DatepickerInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge(:class => "date_picker")
  end
end


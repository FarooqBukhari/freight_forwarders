class DatePickerInput < SimpleForm::Inputs::StringInput
  def input_html_options
    value = object.send(attribute_name)
    options = {
      value: value.nil?? nil : I18n.localize(value),
      data: { provide: "datepicker",
        'date-format': 'dd/mm/yyyy',
        'date-autoclose': 'true',
        'date-today-btn': 'linked',
        'date-today-highlight': 'true',
        'minDate': DateTime.now }
    }
    # add all html option you need...
    super.merge options
  end

  def input_html_classes
    super.push('date_picker')
  end
end

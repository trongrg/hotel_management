$ ->
  clientSideValidations.callbacks.element.fail = (element, message, callback) ->
    callback()
    if element.data("valid") != false
      form_element = if element.is('select') then element.parent().next('span.customStyleSelectBox') else element
      form_element.addClass 'invalid', 100
      form_element.removeClass 'valid', 100

  clientSideValidations.callbacks.element.pass = (element, callback) ->
    callback()
    form_element = element
    form_element.removeClass 'invalid', 0
    form_element.addClass 'valid', 100
    form_element.removeClass 'valid', 700

  clientSideValidations.validators.local["phone_number"] = (element, options)->
    if (!/^(\(\d+\)|\+)?(\s|-|\.)?(\d+(\s|-|\.)?\d+)+(\sx\d+)?$/.test(element.val()))
      return options.message

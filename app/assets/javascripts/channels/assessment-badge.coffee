find_complete = (el) ->
  total = $(el).find('select').size()
  selected = $(el).find('select option[value!=""]').filter(':selected').size()
  return [selected, total]

$(document).on 'change', '[data-behavior="progress"]', ->
  [selected, total] = find_complete(this)

  $($(this).data('target')).html("#{selected} / #{total}")

$(document).on 'change', 'form', ->
  [selected, total] = find_complete(this)

  $(this).find('#total-progress').html("#{selected} / #{total} Complete")
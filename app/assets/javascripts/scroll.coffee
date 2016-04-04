$(document).on 'ready turbolinks:load', ->
  $('[data-behavior="scroll"]').on 'click', (event) ->
    if $(this.hash).size() > 0
      event.preventDefault()
      $('html,body').animate({scrollTop:$(this.hash).offset().top},600)

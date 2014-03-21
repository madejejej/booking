$(document).on('click', '.nav li', () ->
  $('.nav li.active').removeClass('active')
  $(this).addClass('active')
)
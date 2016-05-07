// Delete confirmation modals
$('#confirm-modal-container').on('show', function() {
  var $submit = $(this).find('.btn-danger'),
      href = $submit.attr('href');
  $submit.attr('href', href.replace('pony', $(this).data('id')));
});

$('.confirmation-button').click(function(e) {
  e.preventDefault();
  $('#confirm-modal-container').data('id', $(this).data('id')).modal('show');
});
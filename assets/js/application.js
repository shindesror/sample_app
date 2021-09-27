// Put app-wide JS code here

// additional way of creating jQuery modals when we do not need .modal div wrapper (as it's already included in the partial)
$(document).on('click.modal', 'a[rel~="modal:ajax-open"]', (e) => {
  $.ajax({
    url: $(e.currentTarget).attr('href'),
    success(newHTML) {
      $(newHTML).appendTo('body').modal();
    },
  });

  return false;
});

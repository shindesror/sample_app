$(document).on('submit', '.modal--change-client-name .modal__form', (e) => {
  const $form = $(e.target);
  $.post($form.attr('action'), $form.serialize(), (data) => {
    $(
      `.invoices-table__item-tr[data-id=${data.id}] .invoices-table__item-td--client-name`
    )[0].innerHTML = data.client_name;
    $.modal.close();
  }).fail(function (data) {
    $('.error-message--client-name').html(data.responseText).show();
  });

  return false;
});

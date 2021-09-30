$(document).on('submit', '.modal--add-purchase-order .modal__form', (e) => {
  e.preventDefault();
  const $form = $(e.target);
  $.post($form.attr('action'), $form.serialize(), (data) => {
    if (data.status === 400) {
      handleError(data.errors);
    } else {
      window.location.href = data.location;
    }
    return false;
  });
});

$(document).on('submit', '.purchase-order-form', (e) => {
  e.preventDefault();
  const $form = $(e.target);
  $.post($form.attr('action'), $form.serialize(), (data) => {
    if (data.status === 400) {
      handleError(data.errors);
      return false;
    } else {
      window.location.href = data.location;
    }
  });
});

function handleError(errors) {
  $('.error-message--client-name')
    .html(errors.filter((e) => e.includes('Client')).join(', '))
    .show();
  $('.error-message--amount')
    .html(errors.filter((e) => e.includes('Amount')).join(', '))
    .show();
  $('.error-message--tax')
    .html(errors.filter((e) => e.includes('Tax')).join(', '))
    .show();
  $('.error-message--vendor')
    .html(errors.filter((e) => e.includes('Vendor')).join(', '))
    .show();
  $('.error-message--status')
    .html(errors.filter((e) => e.includes('Status')).join(', '))
    .show();
}

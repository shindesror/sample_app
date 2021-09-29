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

$(document).on('submit', '.modal--add-invoice .modal__form', (e) => {
  const $form = $(e.target);
  $.post($form.attr('action'), $form.serialize(), (data) => {
    if (data.status === 400) {
      handleError(data.errors);
    } else {
      addNewRecord(data.invoice);
      displayMessage(data.invoice.client_name);
      $.modal.close();
    }
  });

  return false;
});

function total(tax, amount) {
  if (tax) {
    return (amount * (1 + tax / 100)).toFixed(2);
  } else {
    return amount;
  }
}

function handleError(errors) {
  $('.error-message--client-name')
    .html(errors.filter((e) => e.includes('Client')))
    .show();
  $('.error-message--amount')
    .html(errors.filter((e) => e.includes('Amount')))
    .show();
  $('.error-message--tax')
    .html(errors.filter((e) => e.includes('Tax')))
    .show();
}

function displayMessage(name) {
  $('main.main').prepend(
    '<div class="flash flash--notice">Invoice for ' + name + ' successfully created.</div>'
  );
}

function addNewRecord(invoice) {
  $('table.invoices-table tbody').prepend(
    '<tr class="invoices-table__item-tr" data-id="' +
      invoice.id +
      '"><td class="invoices-table__item-td invoices-table__item-td--client-name">' +
      invoice.client_name +
      '</td><td class="invoices-table__item-td">$' +
      invoice.amount +
      '</td><td class="invoices-table__item-td">' +
      (invoice.tax || '') +
      '</td><td class="invoices-table__item-td">$' +
      total(invoice.tax, invoice.amount) +
      '</td><td class="invoices-table__item-td invoices-table__item-td--actions"><a class="invoice-action invoice-action--edit-name" rel="modal:ajax-open" title="Change name" href="/invoices/' +
      invoice.id +
      '/xhr_change_client_name"></a><a class="invoice-action invoice-action--delete" title="Delete invoice" rel="nofollow" data-method="delete" href="/invoices/' +
      invoice.id +
      '"></a></td></tr>'
  );
}

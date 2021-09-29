class InvoicesController < ApplicationController
  before_action :find_invoice, only: %w[destroy xhr_change_client_name]

  def index
    @invoices = Invoice.all
  end

  def xhr_add_invoice
    if request.get?
      invoice = Invoice.new
      render partial: 'modal--add-invoice', locals: { invoice: invoice }
    elsif request.post?
      invoice = Invoice.new(invoice_params)
      if invoice.save
        render json: { invoice: invoice }
      else
        render json: {
          errors: invoice.errors.full_messages,
          status: 400
        }
      end
    end
  end

  def destroy
    @invoice.destroy!

    redirect_to invoices_path, notice: "Invoice for #{@invoice.client_name} successfully destroyed."
  end

  def xhr_change_client_name
    if request.get?
      render partial: 'modal--change-client-name', locals: { invoice: @invoice }
    elsif request.patch?
      @invoice.client_name = params[:invoice][:client_name]
      if @invoice.save
        render json: { id: @invoice.id, client_name: @invoice.client_name }
      else
        render json: @invoice.errors.full_messages.first
      end
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:amount, :client_name, :tax)
  end

  def find_invoice
    @invoice = Invoice.find params[:id]
  end
end

class PurchaseOrdersController < ApplicationController
  before_action :find_invoice, only: %w[index xhr_add_purchase_order edit update destroy]
  before_action :find_purchase_order, only: %w[destroy edit update]

  def index
    @purchase_orders = @invoice.purchase_orders
  end

  def xhr_add_purchase_order
    if request.get?
      purchase_order = @invoice.purchase_orders.new
      render partial: 'modal--add-purchase-order', locals: { invoice: @invoice, purchase_order: purchase_order }
    elsif request.post?
      purchase_order = @invoice.purchase_orders.new(purchase_order_params)
      if purchase_order.save
        render_success(edit_invoice_purchase_order_path(@invoice.id, purchase_order.id))
      else
        render_error(purchase_order.errors.full_messages)
      end
    end
  end

  def edit; end

  def update
    if @purchase_order.update(purchase_order_params)
      render_success(invoice_purchase_orders_path(@invoice))
    else
      render_error(@purchase_order.errors.full_messages)
    end
  end

  def destroy
    @purchase_order.destroy!

    redirect_to invoice_purchase_orders_path(@invoice),
                notice: "PurchaseOrder for #{@purchase_order.client_name} successfully destroyed."
  end

  private

  def purchase_order_params
    params.require(:purchase_order).permit(:amount, :client_name, :tax, :vendor, :status)
  end

  def find_invoice
    @invoice = Invoice.find params[:invoice_id]
  end

  def find_purchase_order
    @purchase_order = PurchaseOrder.find params[:id]
  end

  # TODO: These methods should be a part of concern
  def render_success(location)
    render json: { location: location, status: 200 }
  end

  def render_error(errors)
    render json: { errors: errors, status: 400 }
  end
end

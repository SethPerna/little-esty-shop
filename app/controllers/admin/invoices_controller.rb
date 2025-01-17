class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:invoice_status].to_i)
    redirect_to admin_invoice_path(@invoice)
  end
end

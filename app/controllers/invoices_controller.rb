class InvoicesController < ApplicationController 
  
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, notice: I18n.t('invoices.create.notice_create')
    else
      render :new
    end  
  end

  def destroy

  end

  private

  def invoice_params
    params.require(:invoice).permit(:company, :salesperson, :tax, :date)
  end  

end
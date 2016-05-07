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

  # GET /invoices/1
  def show 
    @invoice = Invoice.find(params[:id]) 
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id]) 
  end

  def update
    @invoice = Invoice.find(params[:id]) 
    if @invoice.update_attributes(invoice_params)
      flash.now[:success] = I18n.t('invoices.update.success_update')
      render :show
    else
      render :edit
    end 
  end

  def destroy

  end

  private

  def invoice_params
    params.require(:invoice).permit(:company, :salesperson, :tax, :date)
  end  

end
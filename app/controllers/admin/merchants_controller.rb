class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new

  end

  def create
    Merchant.create(name: params[:name])
    redirect_to "/admin/merchants"
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params[:status]
      @merchant.update(status: params[:status])
      redirect_to "/admin/merchants"
    elsif params[:name]
      @merchant.update(name: params[:name])
      @merchant.save
      flash[:alert] = "Information successfully updated"
      redirect_to "/admin/merchants/#{@merchant.id}"
    end
  end

end

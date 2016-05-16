class DonationsController < ApplicationController
  before_action :require_user
  before_action :set_donation, only: [:show]
  before_action :redirect_if_no_donation, only: [:show]

  def index
    @user = current_user
    @donations = @user.donations
  end

  def show
    @donation_amounts = DonationAmount.where(donation_id: @donation.id) if @donation
  end

  def create
    @donation = current_user.donations.new(donation_params)
    if @donation.save
      @cart.add_donation(@donation)
     #@donation.donation_confirmed(@cart)
     #session.delete :cart
      session[:cart] = @cart.contents
      flash[:notice] = "Donation added to cart"
      redirect_to :back
    else
      flash.now[:error] = @donation.errors.full_messages.join(", ")
      redirect_to :back
    end
  end

  private

  def set_donation
    @donation = current_user.donations.find_by(id: params[:donation_id])
  end

  def redirect_if_no_donation
    redirect_to "/errors/not_found.html" unless @donation
  end

  def donation_params
    donate_params = {}
    donate_params["amount"] = params[:need][:raised]
    donate_params["user_id"] = User.find_by(username: params[:username]).id
    donate_params["need_slug"] = params[:slug]
    donate_params
  end
end

class SessionsController < ApplicationController
  before_action :save_cart, only: [:destroy]

  def new
    if current_user
      redirect_to root_path
    end
    set_redirect
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      set_session_cart(user)
      flash[:notice] = "Logged in as #{user.first_name.capitalize}"
      if current_admin?
        redirect_to admin_profile_path
      else
        redirect_to session[:redirect]
      end
    else
      flash.now[:error] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

private

  def save_cart
    cart = session[:cart].to_json
    current_user.update(cart: cart)
  end

  def set_session_cart(user)
    if user.cart == "{}" || user.cart == nil || user.cart == "null"
      session[:cart] = { "donor" => {}, "recipient" => {} }
    else
      session[:cart] = JSON.parse(user.cart)
    end
    session[:user_id] = user.id
  end
end

class PaymentController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @booking = Booking.find(params[:id])
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => params[:checkout_form][:amount], #this is currently hardcoded params[:checkout_form][:amount]
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )
    byebug
    if result.success?
      byebug
      booking = Booking.find(params[:checkout_form][:booking_id])
      booking.update_attribute(:payment, 1)
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end 
  end

 
end

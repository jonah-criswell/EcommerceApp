class SubscribersController < ApplicationController
  before_action :set_product

  def create
    if authenticated?
      subscriber = @product.subscribers.where(user: current_user).first_or_create
      redirect_to @product, notice: "You are now subscribed to email notifications."
    else
      redirect_to new_session_path, alert: "Please sign in to subscribe to email notifications."
    end
  end

  def destroy
    Rails.logger.info "DESTROY ACTION CALLED!"
    Rails.logger.info "Params: #{params.inspect}"
    if authenticated?
      Rails.logger.info "User authenticated: #{current_user.id}"
      subscriber = @product.subscribers.find_by(user: current_user)
      if subscriber
        Rails.logger.info "Found subscriber: #{subscriber.id}"
        subscriber.destroy
        Rails.logger.info "Destroyed: #{subscriber.destroyed?}"
        redirect_to @product, notice: "Email notifications turned off."
      else
        Rails.logger.info "No subscriber found"
        redirect_to @product, alert: "You are not subscribed to this product."
      end
    else
      Rails.logger.info "User not authenticated"
      redirect_to new_session_path, alert: "Please sign in to manage your subscriptions."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end

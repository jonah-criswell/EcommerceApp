class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: [:destroy]

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: "Review submitted successfully!"
    else
      redirect_to @product, alert: "Error submitting review: #{@review.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    if current_user.admin? || @review.user == current_user
      @review.destroy
      redirect_to @product, notice: "Review deleted successfully!"
    else
      redirect_to @product, alert: "You can only delete your own reviews."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = @product.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

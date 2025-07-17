class ProductMailer < ApplicationMailer
  # Subject can be set in config/locales/en.yml under:
  # en.product_mailer.in_stock.subject

  def in_stock
    @product = params[:product]
    @subscriber = params[:subscriber]

    mail(
      to: @subscriber.email,
      subject: "#{@product.name} is back in stock!"
    )
  end
end

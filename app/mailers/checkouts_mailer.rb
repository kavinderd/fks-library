class CheckoutsMailer < ActionMailer::Base
  default from: "fkslibrary@gmail.com"

  def overdue_alert(checkout)
    @checkout = checkout
    mail(to: ENV["default-email"], subject: "A Checkout is Overdue")
  end

end

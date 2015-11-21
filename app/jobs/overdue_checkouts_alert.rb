class OverdueCheckoutsAlert
  include SuckerPunch::Job

  def perform
    ActiveRecord::Base.connection_pool.with_connection do 
      checkouts = Checkout.where.not(status: :returned).where("due_date < ?", Time.now)
      checkouts.each do |checkout|
        checkout.status = :overdue
        CheckoutsMailer.overdue_alert(checkout).deliver!
        checkout.save!
      end
    end
  end

end

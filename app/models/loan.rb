class Loan < ActiveRecord::Base
  has_many :payments

  def remaining_loan_amount
    payment_amounts = payments.map(&:amount)
    funded_amount - payment_amounts.sum
  end
end

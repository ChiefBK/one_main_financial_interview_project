class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :payment_date, presence: true
  validates :amount, presence: true
  validate :amount_not_greater_than_loan

  def amount_not_greater_than_loan
    if amount.nil?
      return
    end

    if amount > loan.remaining_loan_amount
      errors.add(:amount, 'Can not be greater than amount left on loan')
    end
  end
end

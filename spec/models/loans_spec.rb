require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe '#remaining_loan_amount' do
    let!(:loan) { Loan.create!(funded_amount: 100.0) }

    context 'has no payments' do
      it 'returns the funded amount' do
        expect(loan.remaining_loan_amount).to eq(loan.funded_amount)
      end
    end

    context 'has two payments' do
      let!(:payment_1) { Payment.create!(loan_id: loan.id, payment_date: DateTime.now - 1.day, amount: 10.3)}
      let!(:payment_2) { Payment.create!(loan_id: loan.id, payment_date: DateTime.now - 4.day, amount: 21.1)}
      it 'returns the funded amount minus the sum of payments' do
        expect(loan.remaining_loan_amount).to eq(loan.funded_amount - payment_1.amount - payment_2.amount)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe '#validations' do
    let!(:loan) { Loan.create!(funded_amount: 100.0) }

    context 'amount is not present' do
      it 'raises error' do
        expect { Payment.create!(payment_date: DateTime.now, loan_id: loan.id) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'payment_date is not present' do
      it 'raises error' do
        expect { Payment.create!(amount: 10.0, loan_id: loan.id) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'payment amount is greater than remaining loan' do
      it 'raises error' do
        Payment.create!(amount: 10.0, payment_date: DateTime.now, loan_id: loan.id)
        expect { Payment.create!(amount: 90.1, loan_id: loan.id, payment_date: DateTime.now) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end

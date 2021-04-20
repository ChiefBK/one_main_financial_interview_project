require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  describe '#index' do
    let(:payment_1) { Payment.create!(loan_id: loan.id, amount: 20.34, payment_date: DateTime.now - 5.minutes) }
    let(:payment_2) { Payment.create!(loan_id: loan.id, amount: 10.04, payment_date: DateTime.now - 20.minutes) }

    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:payment) { Payment.create!(loan_id: loan.id, amount: 20.34, payment_date: DateTime.now - 5.minutes) }

    it 'responds with a 200' do
      get :show, params: { loan_id: loan.id, id: payment.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, params: { loan_id: loan.id, id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:create_request_body) do
        {
          loan_id: loan.id,
          data: {
            type: "payments",
            attributes: {
              payment_date: "2021-10-4",
              amount: 38.86
            }
          }
        }
    end

    it 'responds with 201' do
      post :create, params: create_request_body

      expect(response).to have_http_status(:created)
    end

    context 'fails to create record' do
      context 'does not have payment_date param' do
        let(:create_request_body) do
          {
            loan_id: loan.id,
            data: {
              type: "payments",
              attributes: {
                amount: 38.86
              }
            }
          }
        end

        it 'responds with 422' do
          post :create, params: create_request_body

          expect(response).to have_http_status(:unprocessable_entity)
        end

      end
    end
  end
end

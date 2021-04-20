require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    let!(:loan_1) { Loan.create!(funded_amount: 100.0) }
    let!(:loan_2) { Loan.create!(funded_amount: 101.0) }
    it 'responds with a 200' do
      get :index
      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body.length).to eq(2)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, params: { id: loan.id }
      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body.class).to eq(Hash) # should only have one record in response
      expect(body['id']).to eq(loan.id)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

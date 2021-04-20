class PaymentsController < ApplicationController
  def index
    render json: loan.payments
  end

  def create
    full_params = create_params.merge({ loan_id: loan.id })
    payment = Payment.create!(full_params)

    render json: payment, status: :created
  end

  def show
    payment = loan.payments.find(params.require(:id))

    render json: payment
  end

  private

  def loan
    @loan ||= Loan.find(params.require(:loan_id))
  end

  def create_params
    params.require(:data).require(:attributes).permit([:payment_date, :amount])
  end
end

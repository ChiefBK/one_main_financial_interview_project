class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount, :payment_date
end

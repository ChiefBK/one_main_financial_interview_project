class LoanSerializer < ActiveModel::Serializer
  attributes :id, :funded_amount, :remaining_loan_amount
end

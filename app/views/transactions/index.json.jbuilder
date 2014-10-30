json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :item_id, :code, :date, :amount
  json.url transaction_url(transaction, format: :json)
end

Before('@javascript', '@selenium', '@no-txn') do
  DatabaseCleaner.strategy = :truncation
end

After('@javascript', '@selenium', '@no-txn') do
  DatabaseCleaner.clean_with :truncation
end

Before('~@javascript', '~@selenium', '~@no-txn')do
  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.start
end

After('~@javascript', '~@selenium', '~@no-txn')do
  DatabaseCleaner.clean
end

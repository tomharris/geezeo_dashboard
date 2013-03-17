module GeezeoApi
  module ModelFactorySupport

    def valid_account_attributes
      {
        'id'                => 123,
        'name'              => 'my account',
        'balance'           => 10.01,
        'reference_id'      => '12',
        'aggregation_type'  => 'partner',
        'state'             => 'active'
      }
    end

    def valid_account
      Account.from_hash(valid_account_attributes)
    end

    def valid_transaction_attributes
      {
        'id'                => 'bd123b4b-7b33-46d9-a77f-5efc525f67c5',
        'transaction_type'  => 'Debit',
        'memo'              => 'Check #123',
        'balance'           => 61.01,
        'posted_at'         => '2013-03-13T00:00:00+00:00',
        'created_at'        => '2013-03-13T19:36:53+00:00',
        'nickname'          => 'Check #123',
        'original_name'     => 'Check #123',
        'tags'              => [{ 'tag' => { 'name' => "Personal", 'balance' => 61.01 } }]
      }
    end

    def valid_transaction
      Transaction.from_hash(valid_transaction_attributes)
    end
  end
end
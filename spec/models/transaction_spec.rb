require 'spec_helper'

describe Transaction do

  it "should have the right fields" do
    %w(id transaction_type memo balance posted_at created_at nickname original_name tags).each do |field_name|
      Transaction.new.should respond_to(field_name)
    end
  end
end
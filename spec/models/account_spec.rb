require 'spec_helper'

describe Account do

  it "should have the right fields" do
    %w(id name balance reference_id aggregation_type state).each do |field_name|
      Account.new.should respond_to(field_name)
    end
  end
end
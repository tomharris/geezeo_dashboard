require 'spec_helper'

describe "sessions/new" do

  it "renders new session form" do
    render
    assert_select "form", action: sessions_path, method: "post" do
      assert_select 'input', type: 'text', name: 'session[user_id]'
      assert_select 'input', type: 'text', name: 'session[token]'
    end
  end
end

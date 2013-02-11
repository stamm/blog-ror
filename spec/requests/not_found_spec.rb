require 'spec_helper'

describe "Not found page" do

  it 'not found' do
    expect { visit '/afasdfasdf' }.to raise_error(ActionController::RoutingError, 'Not Found')
  end

end
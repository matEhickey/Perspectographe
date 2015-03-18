require 'test_helper'

class ConnectionControllerTest < ActionController::TestCase
  test "should get accueil" do
    get :accueil
    assert_response :success
  end

  test "should get connection" do
    get :connection
    assert_response :success
  end

end

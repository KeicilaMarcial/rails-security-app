# frozen_string_literal: true

require 'application_system_test_case'

class OTPSessionExpiration < ApplicationSystemTestCase
  setup do
    @hopper = users(:hopper)
    sign_in @hopper
  end

  test 'expire after 5 minutes on OTP login page' do
    visit root_path
    assert_selector 'h1', text: 'Dashboard'

    travel_to 5.minutes.after do
      refresh
      assert_selector 'h2', text: 'Log in'
      assert_equal '/users/sign_in', page.current_path
    end
  end
end

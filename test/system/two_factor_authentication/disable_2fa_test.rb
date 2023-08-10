require 'application_system_test_case'

class Disable2FATest < ApplicationSystemTestCase

  setup do
    @hopper = users(:hopper)
    setup_2fa(@hopper)
    sign_in(@hopper)
  end

  test "can success disable 2FA and login without 2FA" do
    visit two_factor_authentication_path
    assert_selector "h1", text: "Autenticação de dois fatores"
    assert_selector "h2", text: "aplicativo autenticador"
    assert_selector "h2", text: "códigos de recuperação"

    click_on "Desativar"
    assert_button "Habilitar"

    click_on "Logout"

  end

end

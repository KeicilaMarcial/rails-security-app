require 'application_system_test_case'

class Setup2FATest < ApplicationSystemTestCase

  setup do
    @hopper = users(:hopper)
    sign_in @hopper
  end

  test "can success setup 2FA and login with it" do
    visit root_path
    assert_selector "h1", text: "Dashboard"

    click_link "MFA"
    assert_selector "h1", text: "Autenticação de dois fatores"
    assert_selector "h2", text: "aplicativo autenticador"

    click_on "Habilitar"
    assert_selector "h1", text: "Configurar autenticação de dois fatores"
    assert_selector "p", text: "Use seu aplicativo de autenticação de dois fatores para escanear o código QR"

    click_on "Cancelar"
    assert_selector "h1", text: "Autenticação de dois fatores"
    assert_equal two_factor_authentication_path, page.current_path

    click_on "Habilitar"
    assert_selector "h1", text: "Configurar autenticação de dois fatores"

    token = scan_the_qr_code_and_get_an_onetime_token(@hopper)
    fill_in_digit_fields_with token
    click_button "Confirme e ative"
    assert_selector "h1", text: "Sucesso na configuração 2FA"
    assert_selector "p", text: "Salve este código de backup de emergência e guarde-o em algum lugar seguro."
    assert_selector "li", count: 12
    all("li").each do |li|
      assert_match /\w{8}/, li.text
    end

    click_on "Feito"
    assert_selector "h1", text: "Autenticação de dois fatores"
    assert_selector "h2", text: "aplicativo autenticador"
    assert_button "Desativar"
    assert_selector "h2", text: "códigos de recuperação"
    assert_button "Regerar"

    click_on "Regerar"
    assert_selector "h1", text: "Êxito na regeneração dos códigos de recuperação"
    assert_selector "p", text: "Salve este código de backup de emergência e guarde-o em algum lugar seguro. (Todos os códigos anteriores expiraram.)"
    assert_selector "li", count: 12
    save_recovery_codes

    click_on "Feito"
    assert_selector "h1", text: "Autenticação de dois fatores"

    click_on "Logout"
    # assert_content "Signed out successfully."
  end

  def save_recovery_codes
    @recovery_codes = all("li").map(&:text)
  end

end

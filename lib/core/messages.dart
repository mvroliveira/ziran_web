class Messages {
  static const String appName = "";

  static const Map<String, String> _ptBr = {
    // Login
    'label_matricula': 'Matrícula',
    'label_pin': 'PIN de Acesso',
    'button_login': 'ENTRAR',
    'error_matricula': 'Informe a matrícula',
    'error_pin': 'PIN inválido',

    // Home
    'home_welcome': 'Olá, Colaborador',
    'home_subtitle': 'Selecione uma operação abaixo:',
    'home_btn_scan': 'LER QR CODE',
    'home_sub_scan': 'Identificar ponto',
    'home_btn_fila': 'FILA DE SEPARAÇÃO',
    'home_sub_fila': 'Ver pedidos',
    'home_btn_dashboard': 'DASHBOARD GERAL',

    // QR Scan
    'scan_title': 'LER QR CODE',
    'scan_instructions': 'Aponte a câmera para o código do ponto',
  };

  static String tr(String key) {
    return _ptBr[key] ?? key;
  }
}
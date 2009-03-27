class LwPagtoCerto
  VERSION = '0.0.1'
  
  MODULO_CARTAO = "CartaoCredito"
  MODULO_BOLETO = "Boleto"
  TIPO_VISA = "Visa"
  TIPO_AMEX = "AmericanExpress"
  TIPO_PESSOA_FISICA = "Fisica"
  TIPO_PESSOA_JURIDICA = "Juridica"
  
  INICIA_COD_RETORNO = {
    :"0" => "Transação iniciada.",
    :"1" => "Dados de entrada incorretos:",
    :"2" => "Vendedor não autenticado.",
    :"3" => "Conta de vendedor desativada.", 
    :"4" => "Conta de comprador desativada.", 
    :"5" => "Dados de comprador incorretos:", 
    :"6" => "XML inválido:", 
    :"7" => "XML mal formatado.", 
    :"8" => "Dados de pagamento incorretos:", 
    :"9" => "Dados de pedido incorretos:", 
    :"10" => "Erro ao iniciar a transação.", 
    :"21" => "CPF não pertence à conta de comprador informada.", 
  }
  
  FINALIZA_COD_RETORNO = {
    :"11" => "Transação não encontrada.", 
    :"12" => "Transação ainda não processada.", 
    :"13" => "Transação em processamento.", 
    :"14" => "Transação expirada.", 
    :"15" => "Transação processada.", 
    :"16" => "Erro ao consultar a transação.", 
    :"17" => "Transação com tempo de pagamento expirado.", 
    :"18" => "Usuário fechou a janela de pagamento.", 
    :"19" => "Pagamento cancelado pelo usuário.", 
    :"20" => "Número máximo de tentativas de pagamento atingido.", 
  }
end
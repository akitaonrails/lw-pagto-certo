require 'xsd/qname'

# {http://www.locaweb.com.br}IniciaTransacao
#   chaveVendedor - SOAP::SOAPString
#   urlRetorno - SOAP::SOAPString
#   xml - SOAP::SOAPString
class IniciaTransacao
  attr_accessor :chaveVendedor
  attr_accessor :urlRetorno
  attr_accessor :xml

  def initialize(chaveVendedor = nil, urlRetorno = nil, xml = nil)
    @chaveVendedor = chaveVendedor
    @urlRetorno = urlRetorno
    @xml = xml
  end
end

# {http://www.locaweb.com.br}IniciaTransacaoResponse
#   iniciaTransacaoResult - SOAP::SOAPString
class IniciaTransacaoResponse
  attr_accessor :iniciaTransacaoResult

  def initialize(iniciaTransacaoResult = nil)
    @iniciaTransacaoResult = iniciaTransacaoResult
  end
end

# {http://www.locaweb.com.br}PagaTransacao
#   chaveVendedor - SOAP::SOAPString
#   urlRetorno - SOAP::SOAPString
#   xml - SOAP::SOAPString
#   xmlCartao - SOAP::SOAPString
class PagaTransacao
  attr_accessor :chaveVendedor
  attr_accessor :urlRetorno
  attr_accessor :xml
  attr_accessor :xmlCartao

  def initialize(chaveVendedor = nil, urlRetorno = nil, xml = nil, xmlCartao = nil)
    @chaveVendedor = chaveVendedor
    @urlRetorno = urlRetorno
    @xml = xml
    @xmlCartao = xmlCartao
  end
end

# {http://www.locaweb.com.br}PagaTransacaoResponse
#   pagaTransacaoResult - SOAP::SOAPString
class PagaTransacaoResponse
  attr_accessor :pagaTransacaoResult

  def initialize(pagaTransacaoResult = nil)
    @pagaTransacaoResult = pagaTransacaoResult
  end
end

# {http://www.locaweb.com.br}ConsultaTransacao
#   chaveVendedor - SOAP::SOAPString
#   idTransacao - SOAP::SOAPString
class ConsultaTransacao
  attr_accessor :chaveVendedor
  attr_accessor :idTransacao

  def initialize(chaveVendedor = nil, idTransacao = nil)
    @chaveVendedor = chaveVendedor
    @idTransacao = idTransacao
  end
end

# {http://www.locaweb.com.br}ConsultaTransacaoResponse
#   consultaTransacaoResult - SOAP::SOAPString
class ConsultaTransacaoResponse
  attr_accessor :consultaTransacaoResult

  def initialize(consultaTransacaoResult = nil)
    @consultaTransacaoResult = consultaTransacaoResult
  end
end

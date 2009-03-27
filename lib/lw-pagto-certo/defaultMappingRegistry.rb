require File.expand_path(File.dirname(__FILE__)) + '/default.rb'
require 'soap/mapping'

module DefaultMappingRegistry
  EncodedRegistry = ::SOAP::Mapping::EncodedRegistry.new
  LiteralRegistry = ::SOAP::Mapping::LiteralRegistry.new
  NsWwwLocawebComBr = "http://www.locaweb.com.br"

  LiteralRegistry.register(
    :class => IniciaTransacao,
    :schema_name => XSD::QName.new(NsWwwLocawebComBr, "IniciaTransacao"),
    :schema_element => [
      ["chaveVendedor", "SOAP::SOAPString", [0, 1]],
      ["urlRetorno", "SOAP::SOAPString", [0, 1]],
      ["xml", "SOAP::SOAPString", [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => IniciaTransacaoResponse,
    :schema_name => XSD::QName.new(NsWwwLocawebComBr, "IniciaTransacaoResponse"),
    :schema_element => [
      ["iniciaTransacaoResult", ["SOAP::SOAPString", XSD::QName.new(NsWwwLocawebComBr, "IniciaTransacaoResult")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => PagaTransacao,
    :schema_name => XSD::QName.new(NsWwwLocawebComBr, "PagaTransacao"),
    :schema_element => [
      ["chaveVendedor", "SOAP::SOAPString", [0, 1]],
      ["urlRetorno", "SOAP::SOAPString", [0, 1]],
      ["xml", "SOAP::SOAPString", [0, 1]],
      ["xmlCartao", "SOAP::SOAPString", [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => PagaTransacaoResponse,
    :schema_name => XSD::QName.new(NsWwwLocawebComBr, "PagaTransacaoResponse"),
    :schema_element => [
      ["pagaTransacaoResult", ["SOAP::SOAPString", XSD::QName.new(NsWwwLocawebComBr, "PagaTransacaoResult")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ConsultaTransacao,
    :schema_name => XSD::QName.new(NsWwwLocawebComBr, "ConsultaTransacao"),
    :schema_element => [
      ["chaveVendedor", "SOAP::SOAPString", [0, 1]],
      ["idTransacao", "SOAP::SOAPString", [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ConsultaTransacaoResponse,
    :schema_name => XSD::QName.new(NsWwwLocawebComBr, "ConsultaTransacaoResponse"),
    :schema_element => [
      ["consultaTransacaoResult", ["SOAP::SOAPString", XSD::QName.new(NsWwwLocawebComBr, "ConsultaTransacaoResult")], [0, 1]]
    ]
  )
end

require File.expand_path(File.dirname(__FILE__)) + '/default.rb'
require File.expand_path(File.dirname(__FILE__)) + '/defaultMappingRegistry.rb'
require 'soap/rpc/driver'

class VendedorSoap < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://www.pagamentocerto.com.br/vendedor/vendedor.asmx"

  Methods = [
    [ "http://www.locaweb.com.br/IniciaTransacao",
      "iniciaTransacao",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://www.locaweb.com.br", "IniciaTransacao"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://www.locaweb.com.br", "IniciaTransacaoResponse"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://www.locaweb.com.br/PagaTransacao",
      "pagaTransacao",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://www.locaweb.com.br", "PagaTransacao"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://www.locaweb.com.br", "PagaTransacaoResponse"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "http://www.locaweb.com.br/ConsultaTransacao",
      "consultaTransacao",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://www.locaweb.com.br", "ConsultaTransacao"]],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://www.locaweb.com.br", "ConsultaTransacaoResponse"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = DefaultMappingRegistry::EncodedRegistry
    self.literal_mapping_registry = DefaultMappingRegistry::LiteralRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end


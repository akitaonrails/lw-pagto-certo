require 'rubygems'
gem "soap4r", "~> 1.5.0"
require 'activesupport'
require 'builder'
require File.expand_path(File.dirname(__FILE__)) + '/lw-pagto-certo/defaultDriver.rb'
require File.expand_path(File.dirname(__FILE__)) + '/lw-pagto-certo/version.rb'

class LwPagtoCerto
  DefaultEndpointUrl = "https://www.pagamentocerto.com.br/vendedor/vendedor.asmx"
  DefaultCheckoutUrl = "https://www.pagamentocerto.com.br/pagamento/pagamento.aspx"
  
  attr_accessor :chave_vendedor # chave criada ao se cadastrar no Pagto. Certo
  attr_accessor :url_retorno    # URL da sua aplicação para onde o Pagto. Certo redirecionará após o pagto.
  
  # Dados de comprador - Hash
  # {
  #   :Nome        => "", #          3 a 255
  #   :Email       => "", #          5 a 100
  #   :Cpf         => "", #          11
  #   :Rg          => "", # opcional 5 a 14
  #   :Ddd         => "", # opcional 2
  #   :Telefone    => "", # opcional 7 a 8
  #   :TipoPessoa  => "", #          6 a 8
  #   :RazaoSocial => "", #          5 a 255
  #   :Cnpj        => "", #          1 a 50
  # }
  attr_accessor :comprador
  
  # Dados de pagamento - Hash
  # { 
  #     :Modulo => "",    #          6 a 13          
  #     :Tipo   => "",    # opcional 0 a 15
  # }
  attr_accessor :pagamento
  
  # Dados do Pedido - Hash
  # {
  #   :Numero         => "",    # seu número interno de controle do pedido
  #   :ValorSubTotal  => "000", # dinheiro = 999.88 = 99988
  #   :ValorFrete     => "000", #   centavos são sempre os dois ultimos digitos
  #   :ValorAcrescimo => "000",
  #   :ValorDesconto  => "000",
  #   :ValorTotal     => "000",
  #   :Itens => { 
  #     :Item => {
  #       :CodProduto    => "",    # 1 a 40 
  #       :DescProduto   => "",    # 1 a 100
  #       :Quantidade    => "0",   # 
  #       :ValorUnitario => "000", # 3 a 14
  #       :ValorTotal    => "000", # 3 a 14
  #     },
  #   },
  #   :Cobranca => {
  #     :Endereco => "",
  #     :Numero   => "",
  #     :Bairro   => "",
  #     :Cidade   => "",
  #     :Cep      => "",  # 8 dígitos
  #     :Estado   => "",  # precisa ser válido, como ex. SP, RJ, etc.
  #   },
  #   :Entrega => {
  #     :Endereco => "",
  #       :Numero   => "",
  #       :Bairro   => "",
  #       :Cidade   => "",
  #       :Cep      => "",  # 8 dígitos
  #       :Estado   => "",  # precisa ser válido, como ex. SP, RJ, etc.
  #   }
  # }
  attr_accessor :pedido
  
  mattr_accessor :soap
  self.soap = ::VendedorSoap.new(DefaultEndpointUrl)
  
  def initialize(options = {})
    self.chave_vendedor = options[:chave_vendedor] || ""
    self.url_retorno = options[:url_retorno] || ""
    %w(comprador pagamento pedido).each do |method|
      send("#{method}=".to_sym, {})
    end
    yield(self) if block_given?
  end
  
  # Inicia Transação
  # 
  # Passa a estrutura Hash com os elementos de Transação documentadas acima
  # ou pega a configuração feita via "setters"
  #
  # Exemplo:
  #
  # lw = LwPagtoCerto.new(:chave_vendedor => "xxxxx", :url_retorno => "http://dominio.com/pagto")
  # lw.comprador = { :Nome => "Fabio", :Email => "fabio.akita@locaweb.com.br", .....}
  # lw.pagamento = { :Modulo => LwPagtoCerto::Modulo::BOLETO }
  # ...
  # retorno = lw.inicia do |l|
  #   l.cobranca = { :Endereco => "", :Numero => "", ..... }
  # end
  #
  # puts retorno[:cod_retorno]
  # puts retorno[:mensagem_retorno]
  def inicia(transacao = nil)
    transacao = transacao || build_transacao
    yield(self) if block_given?
    payload = IniciaTransacao.new( self.chave_vendedor, self.url_retorno, transacao )
    response = LwPagtoCerto.soap.iniciaTransacao(payload)
    response = Hash.from_xml(response.iniciaTransacaoResult)
    response = response["LocaWeb"]["Transacao"].symbolize_keys
    
    response[:data] = Time.parse(response[:data].gsub(/(\d+)\/(\d+)\/(\d+)\s(.*)/, 
      "#{$3}-#{$2}-#{$1}T#{$4}")) if response[:data] 
    if response[:CodRetorno]
      response.instance_eval do 
        def cod_retorno_mensagem
          LwPagtoCerto::INICIA_COD_RETORNO[self[:CodRetorno].to_sym]
        end
      end
    end
    response
  end
  
  # Consulta os Dados de uma Transação que já foi Paga
  #
  # lw = LwPagtoCerto.new(:chave_vendedor => "xxxxx", :url_retorno => "http://dominio.com/pagto")
  # retorno = lw.consulta("xxxxxxxx") # passa Id da transação retornada ao chamar "inicia"
  #
  # puts retorno[:CodRetorno]
  # puts retorno[:IdTransacao]
  # puts retorno[:Codigo]
  # puts retorno[:data]  # => "26/3/2009 15:19:41"
  # puts retorno[:MensagemRetorno]
  def consulta(id_transacao = "")
    payload = ConsultaTransacao.new self.chave_vendedor, id_transacao
    response = LwPagtoCerto.soap.consultaTransacao(payload)
    response = Hash.from_xml(response.consultaTransacaoResult)
    response = response["LocaWeb"]["Transacao"].symbolize_keys
    if response[:CodRetorno]
      response.instance_eval do 
        def cod_retorno_mensagem
          LwPagtoCerto::FINALIZA_COD_RETORNO[self[:CodRetorno].to_sym]
        end
      end
    end
    response
  end
  
  def consultaPedido(id_transacao = "")
    payload = ConsultaTransacao.new self.chave_vendedor, id_transacao
    response = LwPagtoCerto.soap.consultaTransacao(payload)
    response = Hash.from_xml(response.consultaTransacaoResult)
    return response["LocaWeb"]["Pedido"].symbolize_keys if response["LocaWeb"]["Pedido"]
    return []
  end

  # Usado internamento pelo Inicia Transacao para gerar o XML
  # que define a transacao sendo iniciada. Utilize os accessors
  # comprador, pagamento e pedido conforme comentado no começo do
  # arquivo
  def build_transacao
    result = ""
    xml = Builder::XmlMarkup.new(:indent => 2, :target => result)
    xml.instruct!
    xml.LocaWeb do |lw|
      lw.Comprador do |c|
        %w(Nome Email Cpf Rg Ddd Telefone TipoPessoa RazaoSocial Cnpj).each do |field|
          eval "c.#{field} comprador[field.to_sym]" if comprador[field.to_sym]
        end
      end
      lw.Pagamento do |p|
        %w(Modulo Tipo).each do |field|
          eval "p.#{field} pagamento[field.to_sym]" if pagamento[field.to_sym]
        end
      end
      lw.Pedido do |p|
        %w(Numero ValorSubTotal ValorFrete ValorAcrescimo ValorDesconto ValorTotal).each do |field|
          eval "p.#{field} pedido[field.to_sym]" if pedido[field.to_sym]
        end
        if pedido[:Itens]
          p.Itens do |items|
            pedido[:Itens].each do |key, item|
              items.Item do
                %w(CodProduto DescProduto Quantidade ValorUnitario ValorTotal).each do |field|
                  eval "items.#{field} item[field.to_sym]" if item[field.to_sym]
                end
              end
            end
          end
        end
        if pedido[:Cobranca]
          p.Cobranca do |c|
            %w(Endereco Numero Bairro Cidade Cep Estado).each do |field|
              eval "c.#{field} pedido[:Cobranca][field.to_sym]" if pedido[:Cobranca][field.to_sym]
            end            
          end
        end
        if pedido[:Entrega]
          p.Entrega do |c|
            %w(Endereco Numero Bairro Cidade Cep Estado).each do |field|
              eval "c.#{field} pedido[:Cobranca][field.to_sym]" if pedido[:Entrega][field.to_sym]
            end            
          end
        end
      end
    end
    result
  end
  
  def endpoint_url(url)
    soap.endpoint_url = url
  end
end

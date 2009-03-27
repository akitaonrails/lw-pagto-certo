require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe LwPagtoCerto do
  
  before :each do
    @lw = LwPagtoCerto.new(:chave_vendedor => "XXXXXXXX-AAAA-BBBB-CCCC-ZZZZZZZZZZZZ",
      :url_retorno => "http://meusite.dominio.com.br/confirmacao_pagamento")
  end
  
  it "should generate a valid transaction payload" do
    @lw.comprador = {
      :Nome        => "Fabio Akita",
      :Email       => "fabio.akita@locaweb.com.br",
      :Cpf         => "26675175807",
      :Rg          => "123456780",
      :Ddd         => "11",
      :Telefone    => "12345678",
      :TipoPessoa  => "Fisica",
      # :RazaoSocial => "",
      # :Cnpj        => "",
    }
    @lw.pagamento = {
      :Modulo => "Boleto",
      # :Tipo => "",
    }
    @lw.pedido = {
      :Numero => "12345",
      :ValorSubTotal  => "2000",
      :ValorFrete     => "000",
      :ValorAcrescimo => "000",
      :ValorDesconto  => "000",
      :ValorTotal     => "2000",
      :Itens => { 
        :Item => {
          :CodProduto    => "4321",
          :DescProduto   => "Livro",
          :Quantidade    => "1",
          :ValorUnitario => "2000",
          :ValorTotal    => "2000",
        },
      },
      :Cobranca => {
        :Endereco => "Rua Foo",
        :Numero   => "123",
        :Bairro   => "Foo",
        :Cidade   => "Sao Paulo",
        :Cep      => "12345678",
        :Estado   => "SP",
      },
      :Entrega => {
        :Endereco => "Rua Foo",
        :Numero   => "123",
        :Bairro   => "Foo",
        :Cidade   => "Sao Paulo",
        :Cep      => "12345678",
        :Estado   => "SP",
      },
    }
    
    @lw.build_transacao.should == %Q{<?xml version="1.0" encoding="UTF-8"?>\n<LocaWeb>\n  <Comprador>\n    <Nome>Fabio Akita</Nome>\n    <Email>fabio.akita@locaweb.com.br</Email>\n    <Cpf>26675175807</Cpf>\n    <Rg>123456780</Rg>\n    <Ddd>11</Ddd>\n    <Telefone>12345678</Telefone>\n    <TipoPessoa>Fisica</TipoPessoa>\n  </Comprador>\n  <Pagamento>\n    <Modulo>Boleto</Modulo>\n  </Pagamento>\n  <Pedido>\n    <Numero>12345</Numero>\n    <ValorSubTotal>2000</ValorSubTotal>\n    <ValorFrete>000</ValorFrete>\n    <ValorAcrescimo>000</ValorAcrescimo>\n    <ValorDesconto>000</ValorDesconto>\n    <ValorTotal>2000</ValorTotal>\n    <Itens>\n      <Item>\n        <CodProduto>4321</CodProduto>\n        <DescProduto>Livro</DescProduto>\n        <Quantidade>1</Quantidade>\n        <ValorUnitario>2000</ValorUnitario>\n        <ValorTotal>2000</ValorTotal>\n      </Item>\n    </Itens>\n    <Cobranca>\n      <Endereco>Rua Foo</Endereco>\n      <Numero>123</Numero>\n      <Bairro>Foo</Bairro>\n      <Cidade>Sao Paulo</Cidade>\n      <Cep>12345678</Cep>\n      <Estado>SP</Estado>\n    </Cobranca>\n    <Entrega>\n      <Endereco>Rua Foo</Endereco>\n      <Numero>123</Numero>\n      <Bairro>Foo</Bairro>\n      <Cidade>Sao Paulo</Cidade>\n      <Cep>12345678</Cep>\n      <Estado>SP</Estado>\n    </Entrega>\n  </Pedido>\n</LocaWeb>\n}
  end
  
end

unit untEnderecoController;

interface
uses Cliente.Endereco.Model,  Cliente.EnderecoIntegracao.Model, untDataModuleCadastros, System.SysUtils;

type
  TEnderecoController = class

  private

  public
    procedure PesquisarEndereco(iCodCli: Integer);
    procedure CarregarEnderecoCliente(Endereco : TClienteEndereco; iCodEnd : Integer);
    procedure CarregarEnderecoIntegracao(EnderecoIntegracao : TClienteEnderecoIntegracao; iCodEnd : Integer);
    function InserirEnderecos(Endereco : TClienteEndereco; EnderecoIntegracao : TClienteEnderecoIntegracao; iCodEnd : Integer; var sErro : String): Boolean;
    function AlterarEnderecos(Endereco : TClienteEndereco; iCodEnd : Integer; var sErro : String): Boolean;
    function AlterarEnderecoIntegracao(EnderecoIntegracao : TClienteEnderecoIntegracao; iCodEnd : Integer; var sErro : String): Boolean;
    function ExcluirEnderecos(iCodEnd: Integer; excluirTodos : Boolean; iCodigo : Integer; out sErro: String): Boolean;
  end;

implementation

procedure TEnderecoController.PesquisarEndereco(iCodCli: Integer);
begin
  DataModuleCadastros.PesquisarEnderecos(iCodCli);
end;

procedure TEnderecoController.CarregarEnderecoCliente(Endereco: TClienteEndereco; iCodEnd: Integer);
begin
  DataModuleCadastros.CarregarEnderecoClientes(Endereco, iCodEnd);
end;

procedure TEnderecoController.CarregarEnderecoIntegracao(EnderecoIntegracao: TClienteEnderecoIntegracao; iCodEnd: Integer);
begin
  DataModuleCadastros.CarregarEnderecoIntegracao(EnderecoIntegracao, iCodEnd);
end;

function TEnderecoController.InserirEnderecos(Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodEnd: Integer; var sErro: String): Boolean;
begin
  Result :=  DataModuleCadastros.InserirEnderecos(Endereco, EnderecoIntegracao, iCodEnd, sErro);
end;

function TEnderecoController.AlterarEnderecoIntegracao(EnderecoIntegracao: TClienteEnderecoIntegracao; iCodEnd: Integer; var sErro: String): Boolean;
begin
  Result :=  DataModuleCadastros.AlterarEnderecoIntegracao(EnderecoIntegracao, iCodEnd, sErro);
end;

function TEnderecoController.AlterarEnderecos(Endereco : TClienteEndereco; iCodEnd: Integer; var sErro: String): Boolean;
begin
  Result :=  DataModuleCadastros.AlterarEnderecos(Endereco, iCodEnd, sErro);
end;

function TEnderecoController.ExcluirEnderecos(iCodEnd: Integer; excluirTodos : Boolean; iCodigo : Integer; out sErro: String): Boolean;
begin
  Result := DataModuleCadastros.ExcluirEnderecos(iCodEnd, excluirTodos, iCodigo, sErro);
end;

end.

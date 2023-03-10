unit untClienteController;

interface

uses Cliente.Model, Cliente.Endereco.Model, Cliente.EnderecoIntegracao.Model, untDataModuleCadastros, System.SysUtils;

type
  TClienteController = class

  private

  public
    procedure PesquisarCliente(sNome, campoIndice : String);
    procedure CarregarCliente(Cliente : TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodigo : Integer);
    function InserirClientes(Cliente : TCliente; Endereco : TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; var sErro : String): Boolean;
    function AlterarClientes(Cliente : TCliente; var sErro : String): Boolean;
    function ExcluirClientes(iCodigo : Integer; var sErro : String): Boolean;
  end;

implementation

{ TClienteController }

procedure TClienteController.PesquisarCliente(sNome, campoIndice: String);
begin
  DataModuleCadastros.PesquisarClientes(sNome, campoIndice);
end;

procedure TClienteController.CarregarCliente(Cliente: TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodigo: Integer);
begin
  DataModuleCadastros.CarregarClientes(Cliente, Endereco, EnderecoIntegracao, iCodigo);
end;

function TClienteController.InserirClientes(Cliente: TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; var sErro: String): Boolean;
begin
  Result := DataModuleCadastros.InserirClientes(Cliente, Endereco, EnderecoIntegracao, sErro);
end;

function TClienteController.AlterarClientes(Cliente: TCliente;  var sErro: String): Boolean;
begin
  Result := DataModuleCadastros.AlterarClientes(Cliente, sErro);
end;

function TClienteController.ExcluirClientes(iCodigo: Integer; var sErro: String): Boolean;
begin
  Result := DataModuleCadastros.ExcluirClientes(iCodigo, sErro);
end;

end.

unit untClienteController;

interface

uses Cliente.Model, Cliente.Endereco.Model, Cliente.EnderecoIntegracao.Model, untDataModuleCadastros,System.SysUtils,
     Datasnap.DBClient;

type
  TClienteController = class

  private

  public
    procedure PesquisarCliente(sNome, campoIndice : String);
    procedure CarregarCliente(Cliente : TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodigo : Integer);
    function InserirClientes(Cliente : TCliente; Endereco : TClienteEndereco; CdsEnderecos: TClientDataSet; var sErro : String): Boolean;
    function AlterarClientes(Cliente : TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodCli: Integer; var sErro : String): Boolean;
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

function TClienteController.InserirClientes(Cliente: TCliente; Endereco: TClienteEndereco; CdsEnderecos: TClientDataSet; var sErro: String): Boolean;
begin
  Result := DataModuleCadastros.InserirClientes(Cliente, Endereco, CdsEnderecos, sErro);
end;

function TClienteController.AlterarClientes(Cliente: TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodCli: Integer; var sErro: String): Boolean;
begin
  Result := DataModuleCadastros.AlterarClientes(Cliente, Endereco, EnderecoIntegracao, iCodCli, sErro);
end;

function TClienteController.ExcluirClientes(iCodigo: Integer; var sErro: String): Boolean;
begin
  Result := DataModuleCadastros.ExcluirClientes(iCodigo, sErro);
end;

end.

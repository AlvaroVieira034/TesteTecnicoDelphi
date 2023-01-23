unit Cliente.EnderecoIntegracao.Model;

interface

uses System.SysUtils;

type
  TClienteEnderecoIntegracao = class
  private
    FIdEndereco: Integer;
    FDsUF: String;
    FNmCidade: String;
    FNmBairro: String;
    FNmLogradouro: String;
    FDsComplemento: String;

  public
    property IdEndereco : Integer read FIdEndereco write FIdEndereco;
    property DsUf : String read FDsUf write FDsUf;
    property NmCidade : String read FNmCidade write FNMCidade;
    property NmBairro : String read FNmBairro write FNmBairro;
    property NmLogradouro : String read FNmLogradouro write FNmLogradouro;
    property DsComplemento : String read FDsComplemento write FDsComplemento;

  end;

implementation

{ TClienteEnderecoIntegracao }


end.

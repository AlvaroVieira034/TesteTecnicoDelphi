unit Cliente.Endereco.Model;

interface

uses System.SysUtils;

type
  TClienteEndereco = class
  private
    FIdEndereco: Integer;
    FIdPessoa: Integer;
    FDsCep: String;

  public
    property IdEndereco : Integer read FIdEndereco write FIdEndereco;
    property IdPessoa : Integer read FIdPessoa write FIdPessoa;
    property DsCep : String read FDsCep write FDsCep;

  end;

implementation

{ TClienteEndereco }


end.

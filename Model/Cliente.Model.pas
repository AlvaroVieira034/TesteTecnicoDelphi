unit Cliente.Model;

interface

uses
  System.SysUtils;

Type
  TCliente = class
  private
    FIdPessoa: Integer;
    FFlNatureza: Integer;
    FDsDocumento: String;
    FNmPrimeiro: String;
    FNmSegundo: String;
    FDtRegistro : TDateTime;
    procedure SetNome(const Value: String);

  public
    property IdPessoa : Integer read FIdPessoa write FIdPessoa;
    property FlNatureza : Integer read FFlNatureza write FFlNatureza;
    property DsDocumento : String read FDsDocumento write FDsDocumento;
    property NmPrimeiro : String read FNmPrimeiro write SetNome;
    property NmSegundo : String read FNmSegundo write FNmSegundo;
    property DtRegistro : TDateTime read FDtRegistro write FDtRegistro;
  end;

implementation

{ TCliente }

procedure TCliente.SetNome(const Value: String);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O Campo ''Nome'' precisa ser preenchido !');

  FNmPrimeiro := Value;
end;

end.

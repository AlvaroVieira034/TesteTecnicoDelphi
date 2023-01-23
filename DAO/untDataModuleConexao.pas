unit untDataModuleConexao;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Comp.Client, FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait;

type
  TDataModuleConexao = class(TDataModule)
    FDConnection: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleConexao: TDataModuleConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

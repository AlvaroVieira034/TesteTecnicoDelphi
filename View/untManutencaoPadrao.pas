unit untManutencaoPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Data.DB,
  Vcl.DBCtrls;

type
  TFormManutencaoPadrao = class(TForm)
    PanelBotoes: TPanel;
    PanelDados: TPanel;
    SpeedButtonGravar: TSpeedButton;
    SpeedButtonFechar: TSpeedButton;
    DataSourcePadrao: TDataSource;
    SpeedButtonCancelar: TSpeedButton;
    procedure SpeedButtonFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FormManutencaoPadrao: TFormManutencaoPadrao;

implementation

{$R *.dfm}

procedure TFormManutencaoPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFormManutencaoPadrao.SpeedButtonFecharClick(Sender: TObject);
begin
  Close;
end;

end.

unit untEnviarEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, IniFiles,  IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdBaseComponent, IdMessage, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdAttachmentFile, IdText,
  Vcl.ExtCtrls;

type
  TFormEnviarEmail = class(TForm)
    Label3: TLabel;
    EditPara: TEdit;
    Label1: TLabel;
    EditAssunto: TEdit;
    Label2: TLabel;
    memCorpo: TMemo;
    Label4: TLabel;
    EditAnexo: TEdit;
    Panel1: TPanel;
    SpeedButtonEnviar: TSpeedButton;
    SpeedButtonAnexar: TSpeedButton;
    SpeedButtonVoltar: TSpeedButton;
    function EnviarEmail(const AAssunto, ADestino, AAnexo: String; ACorpo: TStrings): Boolean;
    procedure SpeedButtonEnviarClick(Sender: TObject);
    procedure SpeedButtonAnexarClick(Sender: TObject);
    procedure SpeedButtonVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEnviarEmail: TFormEnviarEmail;

implementation

{$R *.dfm}


function TFormEnviarEmail.EnviarEmail(const AAssunto, ADestino, AAnexo: String; ACorpo: TStrings): Boolean;
var
  IniFile              : TIniFile;
  sFrom                : String;
  sBccList             : String;
  sHost                : String;
  iPort                : Integer;
  sUserName            : String;
  sPassword            : String;

  idMsg                : TIdMessage;
  idText               : TIdText;
  idSMTP               : TIdSMTP;
  idSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
  try
    try
      //Criação e leitura do arquivo INI com as configurações
      IniFile                          := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
      sFrom                            := IniFile.ReadString('Email' , 'From'     , sFrom);
      sBccList                         := IniFile.ReadString('Email' , 'BccList'  , sBccList);
      sHost                            := IniFile.ReadString('Email' , 'Host'     , sHost);
      iPort                            := IniFile.ReadInteger('Email', 'Port'     , iPort);
      sUserName                        := IniFile.ReadString('Email' , 'UserName' , sUserName);
      sPassword                        := IniFile.ReadString('Email' , 'Password' , sPassword);

      //Configura os parâmetros necessários para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Variável referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'Envio de Email - Teste LaserChip';
      idMsg.From.Address               := sFrom;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinatário(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
      idMsg.CCList.EMailAddresses      := EditPara.Text;
      idMsg.BccList.EMailAddresses    := sBccList;
      idMsg.BccList.EMailAddresses    := EditPara.Text; //Cópia Oculta

      //Variável do texto
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(ACorpo.Text);
      idText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      //Prepara o Servidor
      idSMTP                           := TIdSMTP.Create(Self);
      idSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      idSMTP.UseTLS                    := utUseImplicitTLS;
      idSMTP.AuthType                  := satDefault;
      idSMTP.Host                      := sHost;
      idSMTP.AuthType                  := satDefault;
      idSMTP.Port                      := iPort;
      idSMTP.Username                  := sUserName;
      idSMTP.Password                  := sPassword;

      //Conecta e Autentica
      idSMTP.Connect;
      idSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conexão foi bem sucedida, envia a mensagem
      if idSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            ShowMessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if idSMTP.Connected then
        idSMTP.Disconnect;

      Result := True;
    finally
      IniFile.Free;

      UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      FreeAndNil(idSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TFormEnviarEmail.SpeedButtonAnexarClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    if Execute then
      EditAnexo.Text := FileName;
end;

procedure TFormEnviarEmail.SpeedButtonEnviarClick(Sender: TObject);
begin
  if EnviarEmail(EditAssunto.Text, EditPara.Text, EditAnexo.Text, memCorpo.Lines) then
  begin
    ShowMessage('Enviado com sucesso!');
    SpeedButtonVoltar.Click;
  end else
    ShowMessage('Não foi possível enviar o e-mail!');

end;

procedure TFormEnviarEmail.SpeedButtonVoltarClick(Sender: TObject);
begin
   Close;
end;

end.

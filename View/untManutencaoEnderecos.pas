unit untManutencaoEnderecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untManutencaoPadrao, Data.DB, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, DbxCommon, Data.SqlExpr;

type
  TOpcao = (opcNovo, opcAlterar, opcNavegar);
  TFormManutencaoEnderecos = class(TFormManutencaoPadrao)
    GroupBoxEnderecos: TGroupBox;
    LabelCliente: TLabel;
    Label6: TLabel;
    EditCep: TEdit;
    Label5: TLabel;
    EditEndereco: TEdit;
    Label9: TLabel;
    EditComplemento: TEdit;
    Label12: TLabel;
    EditEstado: TEdit;
    EditIdEndereco: TEdit;
    Label10: TLabel;
    EditCidade: TEdit;
    SpeedButtonBuscaCep: TSpeedButton;
    EditIdCliente: TEdit;
    Label1: TLabel;
    EditBairro: TEdit;
    procedure FormShow(Sender: TObject);
    procedure SpeedButtonGravarClick(Sender: TObject);
    procedure SpeedButtonBuscaCepClick(Sender: TObject);
    procedure EditCepKeyPress(Sender: TObject; var Key: Char);
    procedure EditCepExit(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaCampos();
    procedure CarregarEnderecos;
    procedure InserirEnderecos;
    procedure AlterarEnderecos;
    procedure GravarDados;
    function ValidarDados: Boolean;
  public
    { Public declarations }
    FOpcao : TOpcao;
  end;

var
  FormManutencaoEnderecos: TFormManutencaoEnderecos;

implementation

{$R *.dfm}

uses Cliente.Endereco.Model, Cliente.EnderecoIntegracao.Model, untEnderecoController, untDataModuleCadastros,
  untFormat, Biblioteca, untMsgAguarde;

{ TFormManutencaoEnderecos }


procedure TFormManutencaoEnderecos.FormShow(Sender: TObject);
begin
  inherited;
  if FOpcao = opcAlterar then
  begin
     CarregarEnderecos();
     EditCep.SetFocus;
  end
  else if FOpcao = opcNovo then
  begin
     LimpaCampos();
     EditCep.SetFocus;
  end;

end;

procedure TFormManutencaoEnderecos.CarregarEnderecos;
var
  ClienteEndereco : TClienteEndereco;
  EnderecoController : TEnderecoController;
  EnderecoIntegracao : TClienteEnderecoIntegracao;
begin
  ClienteEndereco := TClienteEndereco.Create;
  EnderecoIntegracao := TClienteEnderecoIntegracao.Create;
  EnderecoController := TEnderecoController.Create;

  try
    EnderecoController.CarregarEnderecoCliente(ClienteEndereco, DataSourcePadrao.DataSet.FieldByName('IdEndereco').AsInteger);

    with ClienteEndereco do
    begin
      EditIdEndereco.Text := IntToStr(IdEndereco);
      EditCep.Text := DsCep;
      Formatar(EditCep, TFormato.CEP, '');
    end;

    EnderecoController.CarregarEnderecoIntegracao(EnderecoIntegracao, DataSourcePadrao.DataSet.FieldByName('IdEndereco').AsInteger);

    with EnderecoIntegracao do
    begin
      EditEndereco.Text := NmLogradouro;
      EditComplemento.Text := DsComplemento;
      EditBairro.Text := NmBairro;
      EditCidade.Text := NmCidade;
      EditEstado.Text := DsUf;
    end;

  finally
    FreeAndNil(ClienteEndereco);
    FreeAndNil(EnderecoController);
    FreeAndNil(EnderecoIntegracao);
   end;
end;

procedure TFormManutencaoEnderecos.EditCepExit(Sender: TObject);
begin
  inherited;
  Formatar(EditCep, TFormato.CEP, '');
end;

procedure TFormManutencaoEnderecos.EditCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
     key := #0;
end;

procedure TFormManutencaoEnderecos.LimpaCampos;
var i : Integer;
begin
  for i := 0 to FormManutencaoEnderecos.ComponentCount-1 do
  begin
    if FormManutencaoEnderecos.Components[i] is TEdit then
      (FormManutencaoEnderecos.Components[i] as TEdit).Text := '';
  end;



    {EditCep.Text := EmptyStr;
    EditLogradouro.Text := EmptyStr;
    EditNumero.Text := EmptyStr;
    EditComplemento.Text := EmptyStr;
    EditEstado.Text := EmptyStr;
    EditCidade.Text := EmptyStr;}
end;

procedure TFormManutencaoEnderecos.SpeedButtonBuscaCepClick(Sender: TObject);
var
  dadosCep: TDadosCep;
begin
  inherited;
  if not Assigned(FormMsgAguarde) then
    FormMsgAguarde := TFormMsgAguarde.Create(Self);

  FormMsgAguarde.Show;
  FormMsgAguarde.Update;
  EditCep.Text := SoNumeros(EditCep.Text);
  dadosCep := CarregarCep(EditCEP.Text);
  if not dadosCep.sucesso then
  begin
    MessageDlg('Ocorreu um erro ao consultar o CEP. ' + #13 + 'Erro:' + dadosCep.msg, mtError, [mbOK], 0);
    exit;
  end;

  Formatar(EditCep, TFormato.CEP, '');
  EditEndereco.Text := dadosCep.logradouro;
  EditCidade.Text := dadosCep.localidade;
  EditEstado.Text := dadosCep.uf;
  EditCep.SetFocus;
  FreeAndNil(FormMsgAguarde);
end;

procedure TFormManutencaoEnderecos.SpeedButtonGravarClick(Sender: TObject);
begin
  inherited;
  // Grava dados do Endereco
  try
    if not ValidarDados then
      Exit
    else
      GravarDados();
  finally


  end;
end;


function TFormManutencaoEnderecos.ValidarDados: Boolean;
begin
  Result := False;
  if EditCep.Text = EmptyStr then
  begin
    MessageDlg('O CEP do cliente deve ser informado!', mtInformation, [mbOK], 0);
    EditCep.SetFocus;
    Exit;
  end;

  if EditEndereco.Text = EmptyStr then
  begin
    MessageDlg('O endereço do cliente deve ser informado!', mtInformation, [mbOK], 0);
    EditEndereco.SetFocus;
    Exit;
  end;

  if EditComplemento.Text = EmptyStr then
  begin
    MessageDlg('O complemento do endereço deve ser informado!', mtInformation, [mbOK], 0);
    EditComplemento.SetFocus;
    Exit;
  end;

  if EditBairro.Text = EmptyStr then
  begin
    MessageDlg('O complemento do endereço deve ser informado!', mtInformation, [mbOK], 0);
    EditBairro.SetFocus;
    Exit;
  end;

  if EditCidade.Text = EmptyStr then
  begin
    MessageDlg('A cidade do cliente deve ser informada!', mtInformation, [mbOK], 0);
    EditCidade.SetFocus;
    Exit;
  end;

  if EditEstado.Text = EmptyStr then
  begin
    MessageDlg('A UF do cliente deve ser informada!', mtInformation, [mbOK], 0);
    EditEstado.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFormManutencaoEnderecos.GravarDados;
var
  EnderecoController : TEnderecoController;
begin
  EnderecoController := TEnderecoController.Create;
  try
    case FOpcao of
      opcNovo    : InserirEnderecos();
      opcAlterar : AlterarEnderecos();
    end;
  finally
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormManutencaoEnderecos.InserirEnderecos;
var
  ClienteEndereco : TClienteEndereco;
  EnderecoIntegracao : TClienteEnderecoIntegracao;
  EnderecoController : TEnderecoController;
  sErro: String;
begin
  ClienteEndereco := TClienteEndereco.Create;
  EnderecoIntegracao := TClienteEnderecoIntegracao.Create;
  EnderecoController := TEnderecoController.Create;

  try
    with ClienteEndereco do
    begin
      IdPessoa := DataSourcePadrao.DataSet.FieldByName('IDPESSOA').AsInteger;
      DsCep := EditCep.Text;

      with EnderecoIntegracao do
      begin
        DsUf := EditEstado.Text;
        NmCidade := EditCidade.Text;
        NmBairro := EditBairro.Text;
        NmLogradouro := EditEndereco.Text;
        DsComplemento := EditComplemento.Text;
      end;

      if EnderecoController.InserirEnderecos(ClienteEndereco, EnderecoIntegracao, DataSourcePadrao.DataSet.FieldByName('IDPESSOA').AsInteger, sErro) = false then
        raise Exception.Create(sErro)
      else
          MessageDlg('Registro Inserido com sucesso !!', mtInformation, [mbOK], 0);

      DataSourcePadrao.DataSet.Refresh;
      SpeedButtonFechar.Click;
    end;
  finally
    FreeAndNil(ClienteEndereco);
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormManutencaoEnderecos.AlterarEnderecos;
var
  ClienteEndereco : TClienteEndereco;
  EnderecoIntegracao : TClienteEnderecoIntegracao;
  EnderecoController : TEnderecoController;
  sErro : String;
begin
  try
    ClienteEndereco := TClienteEndereco.Create;
    EnderecoIntegracao := TClienteEnderecoIntegracao.Create;
    EnderecoController := TEnderecoController.Create;

    with ClienteEndereco do
    begin
      IdEndereco := StrToInt(EditIdEndereco.Text);
      DsCep := EditCep.Text;
    end;
    if EnderecoController.AlterarEnderecos(ClienteEndereco, StrToInt(EditIdEndereco.Text), sErro) = False then
      raise Exception.Create(sErro)
    else
    begin
      with EnderecoIntegracao do
      begin
        NmLogradouro := EditEndereco.Text;
        DsComplemento := EditComplemento.Text;
        NmBairro := EditBairro.Text;
        NmCidade := EditCidade.Text;
        DsUf := EditEstado.Text;
      end;
      if EnderecoController.AlterarEnderecoIntegracao(EnderecoIntegracao, StrToInt(EditIdEndereco.Text), sErro) = False then
        raise Exception.Create(sErro)
      else
        MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);
    end;
    DataSourcePadrao.DataSet.Refresh;
    SpeedButtonFechar.Click;
  finally
    FreeAndNil(ClienteEndereco);
    FreeAndNil(EnderecoIntegracao);
    FreeAndNil(EnderecoController);
  end;
end;

end.


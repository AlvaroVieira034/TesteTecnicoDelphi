unit untManutencaoClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.UITypes, Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untManutencaoPadrao,
  Data.DB, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Grids, Vcl.DBGrids, untDataModuleConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.DBClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.Provider;

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TFormManutencaoClientes = class(TFormManutencaoPadrao)
{$REGION 'Components'}
    GroupBoxClientes: TGroupBox;
    Label1: TLabel;
    LabelDocumento: TLabel;
    Label4: TLabel;
    Label13: TLabel;
    EditNome: TEdit;
    EditDocumento: TEdit;
    EditSobrenome: TEdit;
    ComboBoxTipoPessoa: TComboBox;
    EditId: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    EditDataRegistro: TEdit;
    GroupBoxEnderecos: TGroupBox;
    Label2: TLabel;
    EditCep: TEdit;
    SpeedButtonIncluirEnd: TSpeedButton;
    SpeedButtonPesquisaCep: TSpeedButton;
    DbGridEnderecos: TDBGrid;
    Bevel1: TBevel;
    Label6: TLabel;
    EditEndereco: TEdit;
    EditComplemento: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditBairro: TEdit;
    Label9: TLabel;
    EditCidade: TEdit;
    Label10: TLabel;
    EditEstado: TEdit;
    QryEnderecos: TFDQuery;
    CdsEnderecos: TClientDataSet;
    DataSourceEnderecos: TDataSource;
    QryEnderecosidendereco: TLargeintField;
    QryEnderecosnmlogradouro: TWideStringField;
    QryEnderecosdscomplemento: TWideStringField;
    QryEnderecosnmbairro: TWideStringField;
    QryEnderecosdscep: TWideStringField;
    QryEnderecosnmcidade: TWideStringField;
    QryEnderecosdsuf: TWideStringField;
    CdsEnderecosnmlogradouro: TWideStringField;
    CdsEnderecosdscomplemento: TWideStringField;
    CdsEnderecosnmbairro: TWideStringField;
    CdsEnderecosdscep: TWideStringField;
    CdsEnderecosnmcidade: TWideStringField;
    CdsEnderecosdsuf: TWideStringField;
    QryEnderecosidpessoa: TIntegerField;
    CdsEnderecosidpessoa: TIntegerField;
    DSProvider: TDataSetProvider;
    SpeedButtonExcluirEnd: TSpeedButton;
{$ENDREGION}
    procedure FormShow(Sender: TObject);
    procedure SpeedButtonGravarClick(Sender: TObject);
    procedure EditDataRegistroKeyPress(Sender: TObject; var Key: Char);
    procedure EditDocumentoChange(Sender: TObject);
    procedure SpeedButtonPesquisaCepClick(Sender: TObject);
    procedure ComboBoxTipoPessoaChange(Sender: TObject);
    procedure SpeedButtonCancelarClick(Sender: TObject);
    procedure SpeedButtonIncluirEndClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditCepExit(Sender: TObject);
    procedure EditEnderecoExit(Sender: TObject);
    procedure EditComplementoExit(Sender: TObject);
    procedure EditBairroExit(Sender: TObject);
    procedure EditCidadeExit(Sender: TObject);
    procedure EditEstadoExit(Sender: TObject);
    procedure EditCepKeyPress(Sender: TObject; var Key: Char);
    procedure EditEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonExcluirEndClick(Sender: TObject);
    procedure DbGridEnderecosCellClick(Column: TColumn);

  private
    procedure LimpaCampos();
    procedure CarregarClientes;
    procedure CarregarEnderecos;
    procedure InserirClientes;
    procedure AlterarClientes;
    procedure GravarDados;
    procedure DefineBtnExcluiEnd;
    function ValidarDados: Boolean;
    function VerificaCampos: Boolean;


  public
    FOperacao : TOperacao;
    vlDouble : Double;
    codCliente : Integer;

  end;

var
  FormManutencaoClientes: TFormManutencaoClientes;

implementation

{$R *.dfm}

uses untDataModuleCadastros, untClienteController, untFormat, Cliente.Model, Cliente.Endereco.Model, Cliente.EnderecoIntegracao.Model,
  System.StrUtils, untEnderecoController, Biblioteca, untMsgAguarde;


procedure TFormManutencaoClientes.FormCreate(Sender: TObject);
begin
  inherited;
  vlDouble := 0;
  codCliente := 0;
  CdsEnderecos.Close;
  QryEnderecos.SQL.Add('and idpessoa = :idpessoa');
  QryEnderecos.ParamByName('idpessoa').AsInteger := 0;
  CdsEnderecos.CreateDataSet;
end;

procedure TFormManutencaoClientes.FormShow(Sender: TObject);
begin
  inherited;
  if FOperacao = opAlterar then
  begin
     CarregarClientes();
     CarregarEnderecos();
     ComboBoxTipoPessoa.SetFocus;
  end
  else
  if FOperacao = opNovo then
  begin
     LimpaCampos();
     ComboBoxTipoPessoa.SetFocus;
  end;
end;

procedure TFormManutencaoClientes.SpeedButtonIncluirEndClick(Sender: TObject);
begin
  inherited;
  CdsEnderecos.Insert;
  CdsEnderecos.FieldByName('DSCEP').AsString := EditCep.Text;
  CdsEnderecos.FieldByName('NMLOGRADOURO').AsString := EditEndereco.Text;
  CdsEnderecos.FieldByName('DSCOMPLEMENTO').AsString := EditComplemento.Text;
  CdsEnderecos.FieldByName('NMBAIRRO').AsString := EditBairro.Text;
  CdsEnderecos.FieldByName('NMCIDADE').AsString := EditCidade.Text;
  CdsEnderecos.FieldByName('DSUF').AsString := EditEstado.Text;
  CdsEnderecos.Post;
  CdsEnderecos.ApplyUpdates(0);

  EditCep.Text := EmptyStr;
  EditEndereco.Text := EmptyStr;
  EditComplemento.Text := EmptyStr;
  EditBairro.Text := EmptyStr;
  EditCidade.Text := EmptyStr;
  EditEstado.Text := EmptyStr;

  ComboBoxTipoPessoa.Enabled := False;
  EditNome.Enabled := False;
  EditSobrenome.Enabled := False;
  EditDocumento.Enabled := False;
  EditDataRegistro.Enabled := False;
  DefineBtnExcluiEnd();
  EditCep.SetFocus;
end;

procedure TFormManutencaoClientes.SpeedButtonCancelarClick(Sender: TObject);
begin
  inherited;
  LimpaCampos();
  ComboBoxTipoPessoa.ItemIndex := 0;
  EditNome.Enabled := True;
  EditSobrenome.Enabled := True;
  EditDocumento.Enabled := True;
  EditDataRegistro.Enabled := True;
  SpeedButtonIncluirEnd.Enabled := False;
  SpeedButtonExcluirEnd.Enabled := False;
  ComboBoxTipoPessoa.Enabled := True;
  ComboBoxTipoPessoa.SetFocus;
  if CdsEnderecos.Active then
  begin
    CdsEnderecos.EmptyDataSet;
    CdsEnderecos.Close;
    CdsEnderecos.Open;
  end;
end;

procedure TFormManutencaoClientes.SpeedButtonExcluirEndClick(Sender: TObject);
begin
  inherited;
  if CdsEnderecos.Active and not CdsEnderecos.IsEmpty then
  begin
    // Remove o registro atualmente selecionado
    CdsEnderecos.Delete;
    DefineBtnExcluiEnd();
  end;
end;

procedure TFormManutencaoClientes.SpeedButtonGravarClick(Sender: TObject);
begin
  inherited;
  // Grava dados do Cliente
  try
    if not ValidarDados then
    begin
      Exit;
    end
    else
    begin
      GravarDados();
    end;

  finally


  end;

end;

procedure TFormManutencaoClientes.SpeedButtonPesquisaCepClick(Sender: TObject);
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
  EditBairro.Text := dadosCep.bairro;
  EditComplemento.Text := dadosCep.complemento;
  FreeAndNil(FormMsgAguarde);

end;

procedure TFormManutencaoClientes.CarregarClientes;
var
  Cliente : TCliente;
  Endereco : TClienteEndereco;
  EnderecoIntegracao : TClienteEnderecoIntegracao;
  ClienteController : TClienteController;
begin
  Cliente := TCliente.Create;
  Endereco := TClienteEndereco.Create;
  EnderecoIntegracao := TClienteEnderecoIntegracao.Create;
  ClienteController := TClienteController.Create;

  try
    ClienteController.CarregarCliente(Cliente, Endereco, EnderecoIntegracao, DataSourcePadrao.DataSet.FieldByName('IdPessoa').AsInteger);

    with Cliente do
    begin
      EditId.Text := IntToStr(IdPessoa);
      EditNome.Text := NmPrimeiro;
      EditSobrenome.Text := NmSegundo;
      ComboBoxTipoPessoa.ItemIndex := FlNatureza;
      EditDocumento.Text := DsDocumento;
      EditDataRegistro.Text := DateToStr(DtRegistro);
    end;

    EditCep.Text := Endereco.DsCep;

    with EnderecoIntegracao do
    begin
      EditEndereco.Text := NmLogradouro;
      EditComplemento.Text := DsComplemento;
      EditBairro.Text := NmBairro;
      EditCidade.Text := NmCidade;
      EditEstado.Text := DsUf;
    end;

  finally
    FreeAndNil(Cliente);
    FreeAndNil(ClienteController);
    FreeAndNil(Endereco);
    FreeAndNil(EnderecoIntegracao);
  end;
end;

procedure TFormManutencaoClientes.CarregarEnderecos;
begin
  CdsEnderecos.Close;
  QryEnderecos.SQL.Add('and idpessoa = :idpessoa');
  QryEnderecos.ParamByName('idpessoa').AsInteger := StrToInt(EditId.Text);
  QryEnderecos.Open();
  CdsEnderecos.CreateDataSet;
  if CdsEnderecos.Active then
  begin
    CdsEnderecos.EmptyDataSet;
    CdsEnderecos.Close;
    CdsEnderecos.Open;
  end;
end;

procedure TFormManutencaoClientes.ComboBoxTipoPessoaChange(Sender: TObject);
begin
  inherited;
  if ComboBoxTipoPessoa.ItemIndex = 1 then
     LabelDocumento.Caption := '            CPF:'
  else
     LabelDocumento.Caption := '          CNPJ:'
end;

procedure TFormManutencaoClientes.EditBairroExit(Sender: TObject);
begin
  inherited;
  VerificaCampos();
end;

procedure TFormManutencaoClientes.EditCepExit(Sender: TObject);
begin
  inherited;
  VerificaCampos();
end;

procedure TFormManutencaoClientes.EditCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9', #8]) then
  begin
    Key := #0;
  end;
end;

procedure TFormManutencaoClientes.EditCidadeExit(Sender: TObject);
begin
  inherited;
  VerificaCampos();
end;

procedure TFormManutencaoClientes.EditComplementoExit(Sender: TObject);
begin
  inherited;
  VerificaCampos();
end;

procedure TFormManutencaoClientes.EditDataRegistroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Formatar(EditDataRegistro, TFormato.Dt, '')
end;

procedure TFormManutencaoClientes.EditDocumentoChange(Sender: TObject);
begin
  inherited;
  if ComboBoxTipoPessoa.ItemIndex = 1  then
     Formatar(EditDocumento, TFormato.CPF, '')
  else
    Formatar(EditDocumento, TFormato.CNPJ, '')
end;

procedure TFormManutencaoClientes.EditEnderecoExit(Sender: TObject);
begin
  inherited;
  VerificaCampos();
end;

procedure TFormManutencaoClientes.EditEstadoExit(Sender: TObject);
begin
  inherited;
  VerificaCampos();
end;

procedure TFormManutencaoClientes.EditEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  VerificaCampos();
end;

procedure TFormManutencaoClientes.LimpaCampos;
var i : Integer;
begin
  for i := 0 to FormManutencaoClientes.ComponentCount-1 do
  begin
    if FormManutencaoClientes.Components[i] is TEdit then
    (FormManutencaoClientes.Components[i] as TEdit).Text:='';

    if FormManutencaoClientes.Components[i] is TMaskEdit then
    (FormManutencaoClientes.Components[i] as TMaskEdit).Text:='';

    if FormManutencaoClientes.Components[i] is TLabeledEdit then
    (FormManutencaoClientes.Components[i] as TLabeledEdit).Text:='';

  end;
  LabelDocumento.Caption := 'Documento:'
end;

procedure TFormManutencaoClientes.GravarDados;
var
  ClienteController : TClienteController;
begin
  ClienteController := TClienteController.Create;
  try
    case FOperacao of
      opNovo    : InserirClientes();
      opAlterar : AlterarClientes();
    end;
  finally
    FreeAndNil(CLienteController);
  end;
end;

procedure TFormManutencaoClientes.InserirClientes;
var
  Cliente : TCliente;
  ClienteController : TClienteController;
  Endereco : TClienteEndereco;
  EnderecoIntegracao : TClienteEnderecoIntegracao;
  sErro: String;
begin
  Cliente := TCliente.Create;
  ClienteController := TClienteController.Create;
  Endereco := TClienteEndereco.Create;
  EnderecoIntegracao := TClienteEnderecoIntegracao.Create;
  try
    with Cliente do
    begin
      NmPrimeiro := EditNome.Text;
      NmSegundo := EditSobrenome.Text;
      FlNatureza := ComboBoxTipoPessoa.ItemIndex;
      DsDocumento := EditDocumento.Text;
      if EditDataRegistro.Text <> '' then
        DtRegistro := StrToDate(EditDataRegistro.Text)
      else
        DtRegistro := StrToDate('01/01/1900');

      Endereco.DsCep := EditCep.Text;
      with EnderecoIntegracao do
      begin
        DsUf := EditEstado.Text;
        NmCidade := EditCidade.Text;
        NmBairro := EditBairro.Text;
        NmLogradouro := EditEndereco.Text;
        DsComplemento := EditComplemento.Text;
      end;

      if ClienteController.InserirClientes(Cliente, Endereco, CdsEnderecos , sErro) = false then
        raise Exception.Create(sErro)
      else
        MessageDlg('Registro incluido com sucesso !!', mtInformation, [mbOk], 0);

      SpeedButtonFechar.Click

    end;
  finally
    FreeAndNil(Cliente);
    FreeAndNil(ClienteController);
    FreeAndNil(Endereco);
    FreeAndNil(EnderecoIntegracao);
  end;
end;

procedure TFormManutencaoClientes.AlterarClientes;
var
  Cliente : TCliente;
  ClienteController : TClienteController;
  sErro : String;
  VlrDouble : Double;
begin
  Cliente := TCliente.Create;
  ClienteController := TClienteController.Create;
  try
    with Cliente do
    begin
      IdPessoa := StrToInt(EditId.Text);
      NmPrimeiro := EditNome.Text;
      FlNatureza := ComboBoxTipoPessoa.ItemIndex;
      DsDocumento := EditDocumento.Text;
      if EditDataRegistro.Text <> '' then
        DtRegistro := StrToDate(EditDataRegistro.Text)
      else
        DtRegistro := StrToDate('01/01/1900');

    end;

    if ClienteController.AlterarClientes(Cliente, sErro) = False then
      raise Exception.Create(sErro)
    else
      MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);

    SpeedButtonFechar.Click
  finally
    FreeAndNil(Cliente);
    FreeAndNil(ClienteController);
  end;
end;

function TFormManutencaoClientes.ValidarDados: Boolean;
begin
  Result := False;
  if ComboBoxTipoPessoa.ItemIndex <= 0 then
  begin
    MessageDlg('Tipo de pessoa deve ser informado!', mtInformation, [mbOK], 0);
    ComboBoxTipoPessoa.Enabled := True;
    ComboBoxTipoPessoa.SetFocus;
    Exit;
  end;

  if EditNome.Text = EmptyStr then
  begin
    MessageDlg('O nome do cliente deve ser informado!', mtInformation, [mbOK], 0);
    EditNome.SetFocus;
    Exit;
  end;

  if EditSobrenome.Text = EmptyStr then
  begin
    MessageDlg('O sobrenome do cliente deve ser informado!', mtInformation, [mbOK], 0);
    EditSobrenome.SetFocus;
    Exit;
  end;

  if EditDocumento.Text = EmptyStr then
  begin
    MessageDlg('O documento do cliente deve ser informado!', mtInformation, [mbOK], 0);
    EditDocumento.SetFocus;
    Exit;
  end;

  if EditDataRegistro.Text = EmptyStr then
  begin
    MessageDlg('A data de registro deve ser informada!', mtInformation, [mbOK], 0);
    EditDataRegistro.SetFocus;
    Exit;
  end;

  if CdsEnderecos.RecordCount <= 0 then
  begin
    MessageDlg('Não existe endereço adicionado para o cliente !', mtInformation, [mbOK], 0);
    EditCep.SetFocus;
    Exit;
  end
  else
  begin
    Result := True;
    Exit;
  end;

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
    MessageDlg('O bairro do endereço deve ser informado!', mtInformation, [mbOK], 0);
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

function TFormManutencaoClientes.VerificaCampos: Boolean;
var i: Integer;
begin
  Result := False;
  if EditCep.Text = '' then Exit;
  if EditEndereco.Text = '' then Exit;
  if EditComplemento.Text = '' then Exit;
  if EditBairro.Text = '' then Exit;
  if EditCidade.Text = '' then Exit;
  if EditEstado.Text = '' then Exit;

  SpeedButtonIncluirEnd.Enabled := True;
  DefineBtnExcluiEnd();
  Result := True;
end;

procedure TFormManutencaoClientes.DbGridEnderecosCellClick(Column: TColumn);
begin
  inherited;
  EditCep.Text := CdsEnderecos.FieldByName('DSCEP').AsString;
  EditEndereco.Text := CdsEnderecos.FieldByName('NMLOGRADOURO').AsString;
  EditComplemento.Text := CdsEnderecos.FieldByName('DSCOMPLEMENTO').AsString;
  EditBairro.Text := CdsEnderecos.FieldByName('NMBAIRRO').AsString;
  EditCidade.Text := CdsEnderecos.FieldByName('NMCIDADE').AsString;
  EditEstado.Text := CdsEnderecos.FieldByName('DSUF').AsString;
end;

procedure TFormManutencaoClientes.DefineBtnExcluiEnd;
begin
  if CdsEnderecos.RecordCount > 0 then
    SpeedButtonExcluirEnd.Enabled := True
  else
    SpeedButtonExcluirEnd.Enabled := False;
end;

end.





unit untManutencaoClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.UITypes, Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untManutencaoPadrao,
  Data.DB, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Grids, Vcl.DBGrids;

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TFormManutencaoClientes = class(TFormManutencaoPadrao)
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
    SpeedButtonAdiciona: TSpeedButton;
    SpeedButtonPesquisaCep: TSpeedButton;
    DBGrid1: TDBGrid;
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
    procedure FormShow(Sender: TObject);
    procedure SpeedButtonGravarClick(Sender: TObject);
    procedure EditDataRegistroKeyPress(Sender: TObject; var Key: Char);
    procedure EditDocumentoChange(Sender: TObject);
    procedure SpeedButtonPesquisaCepClick(Sender: TObject);
    procedure ComboBoxTipoPessoaChange(Sender: TObject);
    procedure SpeedButtonCancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaCampos();
    procedure CarregarClientes;
    procedure InserirClientes;
    procedure AlterarClientes;
    procedure GravarDados;
    function ValidarDados: Boolean;
//    procedure CarregarEnderecos;

  public
    FOperacao : TOperacao;
    vlDouble : Double;
    codCliente : Integer;
    { Public declarations }
  end;

var
  FormManutencaoClientes: TFormManutencaoClientes;

implementation

{$R *.dfm}

uses untDataModuleCadastros, untClienteController, untFormat, Cliente.Model, Cliente.Endereco.Model, Cliente.EnderecoIntegracao.Model,
  System.StrUtils, untEnderecoController, Biblioteca, untMsgAguarde;


procedure TFormManutencaoClientes.FormShow(Sender: TObject);
begin
  inherited;
  vlDouble := 0;
  if FOperacao = opAlterar then
  begin
     CarregarClientes();
     ComboBoxTipoPessoa.SetFocus;
  end
  else
  if FOperacao = opNovo then
  begin
     LimpaCampos();
     ComboBoxTipoPessoa.SetFocus;
  end;

end;

procedure TFormManutencaoClientes.SpeedButtonCancelarClick(Sender: TObject);
begin
  inherited;
  CarregarClientes();
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

procedure TFormManutencaoClientes.ComboBoxTipoPessoaChange(Sender: TObject);
begin
  inherited;
  if ComboBoxTipoPessoa.ItemIndex = 1 then
     LabelDocumento.Caption := '            CPF:'
  else
     LabelDocumento.Caption := '          CNPJ:'
end;

procedure TFormManutencaoClientes.EditDataRegistroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Formatar(EditDataRegistro, TFormato.Dt, '');
end;

procedure TFormManutencaoClientes.EditDocumentoChange(Sender: TObject);
begin
  inherited;
  if ComboBoxTipoPessoa.ItemIndex = 1  then
     Formatar(EditDocumento, TFormato.CPF, '')
  else
    Formatar(EditDocumento, TFormato.CNPJ, '')
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
  {EditId.Text := EmptyStr;
  ComboBoxTipoPessoa.ItemIndex := 0;
  EditNome.Text := EmptyStr;
  EditSobrenome.Text := EmptyStr;
  EditDocumento.Text := EmptyStr;
  EditDataRegistro.Text := EmptyStr;
  EditCep.Text := EmptyStr;
  EditEndereco.Text := EmptyStr;
  EditComplemento.Text := EmptyStr;
  EditBairro.Text := EmptyStr;
  EditCidade.Text := EmptyStr;
  EditEstado.Text := EmptyStr;}
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

      if ClienteController.InserirClientes(Cliente, Endereco, EnderecoIntegracao, sErro) = false then
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
  if ComboBoxTipoPessoa.ItemIndex = 0 then
  begin
    MessageDlg('Tipo de pessoa deve ser informado!', mtInformation, [mbOK], 0);
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

end.





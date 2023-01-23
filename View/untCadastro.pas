unit untCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  IPPeerClient, REST.Client, Data.DB, Datasnap.DBClient, Data.Bind.Components,
  Data.Bind.ObjectScope, XMLDoc, XMLIntf, REST.Types, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, untDataModuleCadastros, untEnderecoController, Vcl.ImgList,
  Vcl.Menus, System.ImageList;

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TClasse = (clDados, clEnderecos);

  TFormCadastro = class(TForm)
    PanelBotoes: TPanel;
    SpeedButtonNovo: TSpeedButton;
    SpeedButtonCancelar: TSpeedButton;
    SpeedButtonEnviarEmail: TSpeedButton;
    SpeedButtonSair: TSpeedButton;
    SpeedButtonGerarXML: TSpeedButton;
    SpeedButtonGravar: TSpeedButton;
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    PanelFundo: TPanel;
    PageControlClientes: TPageControl;
    TabSheetPesquisa: TTabSheet;
    TabSheetDados: TTabSheet;
    GroupBoxDados: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    EditNome: TEdit;
    EditDocumento: TEdit;
    EditTelefone: TEdit;
    EditEmail: TEdit;
    Panel2: TPanel;
    ComboBoxTipoPessoa: TComboBox;
    GroupBoxEndereco: TGroupBox;
    Label6: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SpeedButtonBuscaCep: TSpeedButton;
    Label11: TLabel;
    EditCep: TEdit;
    EditLogradouro: TEdit;
    EditNumero: TEdit;
    EditComplemento: TEdit;
    EditCidade: TEdit;
    EditPais: TEdit;
    DBGridEnderecos: TDBGrid;
    EditEstado: TEdit;
    Label12: TLabel;
    PanelPesquisar: TPanel;
    SpeedButtonEnderecos: TSpeedButton;
    EditPesquisar: TEdit;
    SpeedButtonPesquisar: TSpeedButton;
    Label3: TLabel;
    DbGridPesquisa: TDBGrid;
    DataSourcePesquisa: TDataSource;
    DataSourceEnderecos: TDataSource;
    Label13: TLabel;
    EditId: TEdit;
    SpeedButtonAlterar: TSpeedButton;
    SpeedButtonExcluir: TSpeedButton;
    ImageList: TImageList;
    ComboBoxOpEndereco: TComboBox;
    EditIdEndereco: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButtonNovoClick(Sender: TObject);
    procedure SpeedButtonCancelarClick(Sender: TObject);
    procedure SpeedButtonSairClick(Sender: TObject);
    procedure SpeedButtonGerarXMLClick(Sender: TObject);
    procedure SpeedButtonBuscaCepClick(Sender: TObject);
    procedure EditCepKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonEnviarEmailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DbGridPesquisaDblClick(Sender: TObject);
    procedure DBGridEnderecosCellClick(Column: TColumn);
    procedure EditDocumentoKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonAlterarClick(Sender: TObject);
    procedure SpeedButtonGravarClick(Sender: TObject);
    procedure ComboBoxOpEnderecoChange(Sender: TObject);
    procedure SpeedButtonExcluirClick(Sender: TObject);

  private
    { Private declarations }
    FOperacao : TOperacao;
    FClasse : TClasse;
    procedure ConfiguracoesIniciais;
    procedure PesquisarCliente;
    procedure PesquisarEndereco;
    procedure DetalharClientes;
    procedure CarregarClientes;
    procedure CarregarEnderecos;
    procedure LimpaCampos(campos : String);
    procedure HabilitarControles(aOperacao : TOperacao);
    procedure HabilitarControlesEndereco(aOperacao : TOperacao);
    procedure InserirClientes;
    procedure InserirEnderecos;
    procedure AlterarClientes;
    procedure ExcluirClientes;
    procedure AlterarEnderecos;
    procedure ExcluirEnderecos();
    procedure GravarDados;

  public
    { Public declarations }
  end;

var
  FormCadastro: TFormCadastro;
  quantEnderecos : Integer;
  pathAnexo : string;
  excluirTodos : Boolean;

implementation

{$R *.dfm}

uses Biblioteca, untEnviarEmail, untClienteController, Cliente.Model,  Cliente.Endereco.Model;

procedure TFormCadastro.EditCepKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
     key := #0;
end;

procedure TFormCadastro.EditDocumentoKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
     key := #0;
end;

procedure TFormCadastro.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFormCadastro.FormCreate(Sender: TObject);
begin
  DataModuleCadastros := TDataModuleCadastros.Create(nil);
end;

procedure TFormCadastro.FormShow(Sender: TObject);
begin
  FClasse := clDados;
  excluirTodos := False;
  ConfiguracoesIniciais();
  SpeedButtonPesquisar.Click;
end;

procedure TFormCadastro.ConfiguracoesIniciais;
begin
  TabSheetPesquisa.TabVisible := True;
  TabSheetDados.TabVisible := False;
  PageControlClientes.ActivePage := TabSheetPesquisa;
  HabilitarControles(opNavegar);
end;

procedure TFormCadastro.HabilitarControles(aOperacao: TOperacao);
begin
  case aOperacao of
    opNovo,opAlterar:
    begin
      EditNome.Enabled := True;
      ComboBoxTipoPessoa.Enabled := True;
      EditDocumento.Enabled := True;
      EditTelefone.Enabled := True;
      EditEmail.Enabled := True;

      SpeedButtonNovo.Enabled := False;
      SpeedButtonAlterar.Enabled := False;
      SpeedButtonExcluir.Enabled := False;
      SpeedButtonGravar.Enabled := True;
      SpeedButtonCancelar.Enabled := True;
      SpeedButtonGerarXML.Enabled := False;
      SpeedButtonEnviarEmail.Enabled := False;
      ComboBoxOpEndereco.Enabled := False;
      SpeedButtonSair.Enabled := False;
      DBGridEnderecos.Enabled := False;

      EditNome.SetFocus;
    end;
    opNavegar:
    begin
      EditNome.Enabled := False;
      ComboBoxTipoPessoa.Enabled := False;
      EditDocumento.Enabled := False;
      EditTelefone.Enabled := False;
      EditEmail.Enabled := False;

      EditCep.Enabled := False;
      SpeedButtonBuscaCep.Enabled := False;
      EditLogradouro.Enabled := False;
      EditNumero.Enabled := False;
      EditComplemento.Enabled := False;
      EditEstado.Enabled := False;
      EditCidade.Enabled := False;
      EditPais.Enabled := False;

      SpeedButtonNovo.Enabled := True;
      SpeedButtonAlterar.Enabled := True;
      SpeedButtonExcluir.Enabled := True;
      SpeedButtonGravar.Enabled := False;
      SpeedButtonCancelar.Enabled := False;
      SpeedButtonGerarXML.Enabled := True;
      SpeedButtonEnviarEmail.Enabled := True;
      SpeedButtonSair.Enabled := True;

      ComboBoxOpEndereco.ItemIndex := 0;
      ComboBoxOpEndereco.Enabled := True;
      DBGridEnderecos.Enabled := True;
    end;
  end;
end;

procedure TFormCadastro.HabilitarControlesEndereco(aOperacao: TOperacao);
begin
  DBGridEnderecos.DataSource.DataSet.Open;
  case aOperacao of
    opNovo,opAlterar:
    begin
      if aOperacao = opNovo then
         LimpaCampos('');

      EditCep.Enabled := True;
      SpeedButtonBuscaCep.Enabled := True;
      EditLogradouro.Enabled := True;
      EditNumero.Enabled := True;
      EditComplemento.Enabled := True;
      EditEstado.Enabled := True;
      EditCidade.Enabled := True;
      EditPais.Enabled := True;

      SpeedButtonNovo.Enabled := False;
      SpeedButtonAlterar.Enabled := False;
      SpeedButtonExcluir.Enabled := False;
      SpeedButtonGravar.Enabled := True;
      SpeedButtonCancelar.Enabled := True;
      SpeedButtonGerarXML.Enabled := False;
      SpeedButtonEnviarEmail.Enabled := False;
      SpeedButtonSair.Enabled := False;
      ComboBoxOpEndereco.Enabled := False;
      DBGridEnderecos.Enabled := False;
      EditCep.SetFocus
    end;
    opNavegar:
    begin
      EditCep.Enabled := False;
      SpeedButtonBuscaCep.Enabled := False;
      EditLogradouro.Enabled := False;
      EditNumero.Enabled := False;
      EditComplemento.Enabled := False;
      EditEstado.Enabled := False;
      EditCidade.Enabled := False;
      EditPais.Enabled := False;

      SpeedButtonNovo.Enabled := True;
      SpeedButtonAlterar.Enabled := True;
      SpeedButtonExcluir.Enabled := True;
      SpeedButtonGravar.Enabled := False;
      SpeedButtonCancelar.Enabled := False;
      SpeedButtonGerarXML.Enabled := True;
      SpeedButtonEnviarEmail.Enabled := True;
      SpeedButtonSair.Enabled := True;
      ComboBoxOpEndereco.Enabled := True;
      DBGridEnderecos.Enabled := True;
    end;
  end;
end;

procedure TFormCadastro.SpeedButtonPesquisarClick(Sender: TObject);
begin
  PesquisarCliente();
end;

procedure TFormCadastro.SpeedButtonNovoClick(Sender: TObject);
begin
  FOperacao := opNovo;
  TabSheetPesquisa.TabVisible := False;
  TabSheetDados.TabVisible := True;
  PageControlClientes.ActivePage := TabSheetDados;
  LimpaCampos('TODOS');
  DBGridEnderecos.DataSource.DataSet.Close;
  HabilitarControles(opNovo);
end;


procedure TFormCadastro.SpeedButtonAlterarClick(Sender: TObject);
begin
  FOperacao := opAlterar;
  TabSheetPesquisa.TabVisible := False;
  TabSheetDados.TabVisible := True;
  PageControlClientes.ActivePage := TabSheetDados;
  CarregarClientes();
  PesquisarEndereco();
  DetalharClientes();
  HabilitarControles(opAlterar);
end;

procedure TFormCadastro.SpeedButtonGravarClick(Sender: TObject);
begin
  if FClasse = clDados then
  begin
    // Grava dados do Cliente
    if ComboBoxTipoPessoa.ItemIndex < 1 then
    begin
      MessageDlg('Informe o tipo de Pessoa', mtError, [mbOK], 0);
      ComboBoxTipoPessoa.SetFocus;
    end else
    begin
      GravarDados();
      HabilitarControles(opNavegar);
      TabSheetPesquisa.TabVisible := True;
      SpeedButtonPesquisar.Click
    end;
  end else // Grava dados do endereço -> FClasse = clEndereco
  begin
    GravarDados();
    TabSheetPesquisa.TabVisible := True;
    TabSheetDados.TabVisible := True;
    PageControlClientes.ActivePage := TabSheetDados;
    HabilitarControlesEndereco(opNavegar);
    HabilitarControles(opNavegar);
    DBGridEnderecos.DataSource.DataSet.Refresh;
  end;
end;

procedure TFormCadastro.SpeedButtonCancelarClick(Sender: TObject);
begin
  if FClasse = clDados then
  begin
    // Classe Dados
    if (FOperacao = opNovo) then
       ConfiguracoesIniciais()
    else if FOperacao = opAlterar then
    begin
      TabSheetPesquisa.TabVisible := True;
      TabSheetDados.TabVisible := True;
      PageControlClientes.ActivePage := TabSheetDados;
      HabilitarControles(opNavegar);
    end;
  end else
  begin
    // Classe Endereços
    if (FOperacao = opNovo) then
      LimpaCampos('')
    else if FOperacao = opAlterar then
    begin
      TabSheetPesquisa.TabVisible := True;
      TabSheetDados.TabVisible := True;
      PageControlClientes.ActivePage := TabSheetDados;
    end;
    HabilitarControles(opNavegar);
  end;
  FClasse := clDados;
  FOperacao := opNavegar;
end;

procedure TFormCadastro.SpeedButtonGerarXMLClick(Sender: TObject);
var
  XMLDocument: TXMLDocument;
  NodeTabela, NodeRegistro, NodeEndereco: IXMLNode;
  I: Integer;
  pastaEXE : string;
begin
  // Gera Arquivo XML

  pastaEXE := ExtractFileDir(GetCurrentDir);

  XMLDocument := TXMLDocument.Create(Self);
  try
    XMLDocument.Active := True;
    NodeTabela := XMLDocument.AddChild('Clientes');

    NodeRegistro := NodeTabela.AddChild('Dados');
    NodeRegistro.ChildValues['Nome'] := EditNome.Text;
    NodeRegistro.ChildValues['Identidade'] := EditDocumento.Text;
    //NodeRegistro.ChildValues['CPF'] := EditCPF.Text;
    NodeRegistro.ChildValues['Telefone'] := EditTelefone.Text;
    NodeRegistro.ChildValues['Email'] := EditEmail.Text;

    NodeEndereco := NodeRegistro.AddChild('Endereco');
    NodeEndereco.ChildValues['Cep'] := EditCep.Text;
    NodeEndereco.ChildValues['Logradouro'] := EditLogradouro.Text;
    NodeEndereco.ChildValues['Numero'] := EditNumero.Text;
    NodeEndereco.ChildValues['Complemento'] := EditComplemento.Text;
    NodeEndereco.ChildValues['Cidade'] := EditCidade.Text;
    NodeEndereco.ChildValues['Pais'] := EditPais.Text;

    pathAnexo := pastaEXE + '\ArqXMLProva.xml';
    XMLDocument.SaveToFile(pathAnexo);

    MessageDlg('Arquivo Cliente.XML criado com sucesso !',mtInformation,[mbOk],0);

  finally
    XMLDocument.Free;
  end;

end;

procedure TFormCadastro.SpeedButtonEnviarEmailClick(Sender: TObject);
begin
if not Assigned(FormEnviarEmail) then
  FormEnviarEmail := TFormEnviarEmail.Create(Self);
  FormEnviarEmail.EditPara.Text := EditEmail.Text;
  FormEnviarEmail.EditAnexo.Text := pathAnexo;
  FormEnviarEmail.ShowModal;
  FreeAndNil(FormEnviarEmail);
end;

procedure TFormCadastro.SpeedButtonExcluirClick(Sender: TObject);
begin
  ExcluirClientes();
  ConfiguracoesIniciais();
  SpeedButtonPesquisar.Click;
end;

procedure TFormCadastro.SpeedButtonSairClick(Sender: TObject);
begin
  Application.Terminate;
  Close;
end;

procedure TFormCadastro.PesquisarCliente;
var
  ClienteController : TClienteController;
begin
  ClienteController := TClienteController.Create;
  try
    ClienteController.PesquisarCliente(EditPesquisar.Text);
  finally
    FreeAndNil(ClienteController);
  end;
end;

procedure TFormCadastro.PesquisarEndereco;
var
  EnderecoController : TEnderecoController;
begin
  EnderecoController := TEnderecoController.Create;

  try
    EnderecoController.PesquisarEndereco(StrToInt(EditId.Text));
  finally
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormCadastro.InserirClientes;
var
  Cliente : TCliente;
  ClienteController : TClienteController;
  sErro: String;
begin
  Cliente := TCliente.Create;
  ClienteController := TClienteController.Create;

  try
    with Cliente do
    begin
      Nome := EditNome.Text;
      if ComboBoxTipoPessoa.ItemIndex = 1 then
        Tipo := 'F'
      else if ComboBoxTipoPessoa.ItemIndex = 2 then
        Tipo := 'J'
      else
        Tipo := '';

      Documento := EditDocumento.Text;
      Telefone := EditTelefone.Text;
      Email := EditEmail.Text;

      if ClienteController.InserirClientes(Cliente, sErro) = false then
        raise Exception.Create(sErro)
      else
        MessageDlg('Registro incluido com sucesso !!', mtInformation, [mbOk], 0);
    end;
  finally
    FreeAndNil(Cliente);
    FreeAndNil(ClienteController);
  end;
end;

procedure TFormCadastro.AlterarClientes;
var
  Cliente : TCliente;
  ClienteController : TClienteController;
  sErro : String;
begin
  Cliente := TCliente.Create;
  ClienteController := TClienteController.Create;

  try
    with Cliente do
    begin
      IdCliente := StrToInt(EditId.Text);
      Nome := EditNome.Text;
      if ComboBoxTipoPessoa.ItemIndex = 1 then
        Tipo := 'F'
      else if ComboBoxTipoPessoa.ItemIndex = 2 then
        Tipo := 'J'
      else
        Tipo := '';

      Documento := EditDocumento.Text;
      Telefone := EditTelefone.Text;
      Email := EditEmail.Text;
    end;

    if ClienteController.AlterarClientes(Cliente, sErro) = False then
      raise Exception.Create(sErro)
    else
      MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);
  finally
    FreeAndNil(Cliente);
    FreeAndNil(ClienteController);
  end;
end;

procedure TFormCadastro.ExcluirClientes;
var
  ClienteController : TClienteController;
  sErro : String;
begin
  ClienteController := TClienteController.Create;

  try
    if DBGridEnderecos.DataSource.DataSet.RecordCount > 0 then
    begin
      if MessageDlg('Existem endereço(s) associado a esse cliente, deseja excluir cliente e todos endereços asssociados ?', mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      begin
        excluirTodos := True;
        ExcluirEnderecos();
        if ClienteController.ExcluirClientes(StrToInt(EditId.Text), sErro) = False then
          raise Exception.Create(sErro);
      end;
    end else
    begin
      if MessageDlg('Deseja realmente excluir o Cliente selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
        if ClienteController.ExcluirClientes(StrToInt(EditId.Text), sErro) = False then
          raise Exception.Create(sErro);
    end;
  finally
    FreeAndNil(ClienteController);
  end;
end;

procedure TFormCadastro.InserirEnderecos;
var
  ClienteEndereco : TClienteEndereco;
  EnderecoController : TEnderecoController;
  sErro: String;
begin
  ClienteEndereco := TClienteEndereco.Create;
  EnderecoController := TEnderecoController.Create;

  try
    with ClienteEndereco do
    begin
      IdCliente := StrToInt(EditId.Text);
      Cep := EditCep.Text;
      Logradouro := EditLogradouro.Text;
      Numero := EditNumero.Text;
      Complemento := EditComplemento.Text;
      Cidade := EditCidade.Text;
      Estado := EditEstado.Text;
      Pais := EditPais.Text;

      if EnderecoController.InserirEnderecos(ClienteEndereco, StrToInt(EditId.Text), sErro) = false then
        raise Exception.Create(sErro)
      else
        MessageDlg('Endereço incluido com sucesso !!', mtInformation, [mbOk], 0);
    end;

  finally
    FreeAndNil(ClienteEndereco);
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormCadastro.AlterarEnderecos;
var
  ClienteEndereco : TClienteEndereco;
  EnderecoController : TEnderecoController;
  sErro : String;
begin
  try
    ClienteEndereco := TClienteEndereco.Create;
    EnderecoController := TEnderecoController.Create;

    with ClienteEndereco do
    begin
      IdEndereco := StrToInt(EditIdEndereco.Text);
      Cep := EditCep.Text;
      Logradouro := EditLogradouro.Text;
      Numero := EditNumero.Text;
      Complemento := EditComplemento.Text;
      Estado := EditEstado.Text;
      Cidade := EditCidade.Text;
      Pais := EditPais.Text;
    end;

    if EnderecoController.AlterarEnderecos(ClienteEndereco, StrToInt(EditIdEndereco.Text), sErro) = False then
      raise Exception.Create(sErro)
    else
      MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);
  finally
    FreeAndNil(ClienteEndereco);
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormCadastro.ExcluirEnderecos;
var
  EnderecoController : TEnderecoController;
  sErro : String;
begin
  EnderecoController := TEnderecoController.Create;

  try
    if excluirTodos = False then
    begin
      if MessageDlg('Deseja realmente excluir o endereço selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
      begin
        if EnderecoController.ExcluirEnderecos(StrToInt(EditIdEndereco.Text), excluirTodos, StrToInt(EditId.Text), sErro) = False then
          raise Exception.Create(sErro);

        DBGridEnderecos.DataSource.DataSet.Refresh;
      end;
    end else
      if EnderecoController.ExcluirEnderecos(StrToInt(EditIdEndereco.Text), excluirTodos, StrToInt(EditId.Text), sErro) = False then
          raise Exception.Create(sErro);

  finally
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormCadastro.GravarDados;
var
  ClienteController : TClienteController;
  EnderecoController : TEnderecoController;
begin
  ClienteController := TClienteController.Create;
  EnderecoController := TEnderecoController.Create;

  try
    if FClasse = clDados then
    begin
      case FOperacao of
        opNovo    : InserirClientes();
        opAlterar : AlterarClientes();
      end;
    end else
    begin
      case FOperacao of
        opNovo    : InserirEnderecos();
        opAlterar : AlterarEnderecos();
      end;
    end;
  finally
    FreeAndNil(CLienteController);
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormCadastro.ComboBoxOpEnderecoChange(Sender: TObject);
begin
  if ComboBoxOpEndereco.ItemIndex > 0 then
  begin
    FClasse := clEnderecos;
    FOperacao := opNavegar;

    case ComboBoxOpEndereco.ItemIndex of
       1 : FOperacao := opNovo;  // Incluir Endereços

       2 : if DataSourceEnderecos.DataSet.RecordCount > 0 then  // Alterar Endereços
             FOperacao := opAlterar
           else
             MessageDlg('Não existe endereço para ser alterado !!', mtWarning, [mbOk], 0);

       3 : // Excluir Endereços
       begin
         if DataSourceEnderecos.DataSet.RecordCount > 0 then
         begin
            ExcluirEnderecos();
            ComboBoxOpEndereco.ItemIndex := 0;
            LimpaCampos('');
            CarregarEnderecos();
         end else
           MessageDlg('Não existe endereço para ser excluido !!', mtWarning, [mbOk], 0);
       end;
    end;

    HabilitarControlesEndereco(FOperacao);

  end;
end;

procedure TFormCadastro.LimpaCampos(campos : String);
begin
  if campos = 'TODOS' then
  begin
    EditId.Text := EmptyStr;
    EditNome.Text := EmptyStr;
    ComboBoxTipoPessoa.ItemIndex := 0;
    EditDocumento.Text := EmptyStr;
    EditTelefone.Text := EmptyStr;
    EditEmail.Text := EmptyStr;
    EditCep.Text := EmptyStr;
    EditLogradouro.Text := EmptyStr;
    EditNumero.Text := EmptyStr;
    EditComplemento.Text := EmptyStr;
    EditEstado.Text := EmptyStr;
    EditCidade.Text := EmptyStr;
    EditPais.Text := EmptyStr;
  end else
  begin
    EditCep.Text := EmptyStr;
    EditLogradouro.Text := EmptyStr;
    EditNumero.Text := EmptyStr;
    EditComplemento.Text := EmptyStr;
    EditEstado.Text := EmptyStr;
    EditCidade.Text := EmptyStr;
    EditPais.Text := EmptyStr;
    ComboBoxTipoPessoa.ItemIndex := 0;
  end
end;


procedure TFormCadastro.SpeedButtonBuscaCepClick(Sender: TObject);
var
  dadosCep: TDadosCep;
begin
  dadosCep := CarregarCep(EditCEP.Text);

  if not dadosCep.sucesso then
  begin
    MessageDlg('Ocorreu um erro ao consultar o CEP. ' + #13 + 'Erro:' + dadosCep.msg, mtError, [mbOK], 0);
    exit;
  end;
  EditLogradouro.Text := dadosCep.logradouro;
  EditCidade.Text := dadosCep.localidade;
  EditEstado.Text := dadosCep.uf;
  EditPais.Text := 'Brasil';
  EditNumero.SetFocus;
end;

procedure TFormCadastro.DetalharClientes;
begin
  TabSheetDados.TabVisible := True;
  PageControlClientes.ActivePage := TabSheetDados;
  CarregarClientes();
end;

procedure TFormCadastro.CarregarClientes;
var
  Cliente : TCliente;
  ClienteController : TClienteController;
begin
  Cliente := TCliente.Create;
  ClienteController := TClienteController.Create;

  try
    ClienteController.CarregarCliente(Cliente, DataSourcePesquisa.DataSet.FieldByName('IdCliente').AsInteger);

    with Cliente do
    begin
      EditId.Text := IntToStr(IdCliente);
      EditNome.Text := Nome;
      if Tipo = 'F' then
         ComboBoxTipoPessoa.ItemIndex := 1
      else if Tipo = 'J' then
         ComboBoxTipoPessoa.ItemIndex := 2
      else
         ComboBoxTipoPessoa.ItemIndex := -1;

      EditDocumento.Text := Documento;
      EditTelefone.Text := Telefone;
      EditEmail.Text := Email;
    end;
  finally
    FreeAndNil(Cliente);
    FreeAndNil(ClienteController);
  end;
end;

procedure TFormCadastro.CarregarEnderecos;
var
  ClienteEndereco : TClienteEndereco;
  EnderecoController : TEnderecoController;
begin
  ClienteEndereco := TClienteEndereco.Create;
  EnderecoController := TEnderecoController.Create;

  try
    EnderecoController.CarregarEnderecoCliente(ClienteEndereco, DataSourceEnderecos.DataSet.FieldByName('IdEndereco').AsInteger);

    with ClienteEndereco do
    begin
      EditIdEndereco.Text := IntToStr(ClienteEndereco.IdEndereco);
      EditCep.Text := ClienteEndereco.Cep;
      EditLogradouro.Text := ClienteEndereco.Logradouro;
      EditNumero.Text := ClienteEndereco.Numero;
      EditComplemento.Text := ClienteEndereco.Complemento;
      EditEstado.Text := ClienteEndereco.Estado;
      EditCidade.Text := ClienteEndereco.Cidade;
      EditPais.Text := ClienteEndereco.Pais;
    end;

  finally
    FreeAndNil(ClienteEndereco);
    FreeAndNil(EnderecoController);
   end;
end;

procedure TFormCadastro.DBGridEnderecosCellClick(Column: TColumn);
begin
  CarregarEnderecos();
end;

procedure TFormCadastro.DbGridPesquisaDblClick(Sender: TObject);
begin
  DetalharClientes();
  LimpaCampos('');
  PesquisarEndereco();
  if DataSourceEnderecos.DataSet.RecordCount > 0 then
  begin
    EditIdEndereco.Text := DataSourceEnderecos.DataSet.FieldByName('IdEndereco').AsString;
    EditCep.Text := DataSourceEnderecos.DataSet.FieldByName('Cep').AsString;
    EditLogradouro.Text := DataSourceEnderecos.DataSet.FieldByName('Logradouro').AsString;
    EditNumero.Text := DataSourceEnderecos.DataSet.FieldByName('Numero').AsString;
    EditComplemento.Text := DataSourceEnderecos.DataSet.FieldByName('Complemento').AsString;
    EditEstado.Text := DataSourceEnderecos.DataSet.FieldByName('Estado').AsString;
    EditCidade.Text := DataSourceEnderecos.DataSet.FieldByName('Cidade').AsString;
    EditPais.Text := DataSourceEnderecos.DataSet.FieldByName('Pais').AsString;
  end;

  DBGridEnderecos.SetFocus;
end;

end.



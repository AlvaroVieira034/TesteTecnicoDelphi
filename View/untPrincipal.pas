unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,  Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.ImageList, Vcl.ImgList, XMLDoc, XMLIntf, REST.Types, StrUtils;

type
  TClasse = (clCliente, clEnderecos);
  TFormPrincipal = class(TForm)
{$REGION 'Components'}
    PanelBotoesMenu: TPanel;
    SpeedButtonClientes: TSpeedButton;
    SpeedButtonRelatorios: TSpeedButton;
    SpeedButtonSair: TSpeedButton;
    SpeedButtonEnderecos: TSpeedButton;
    PanelClientes: TPanel;
    PanelEndereco: TPanel;
    PanelBotoesClientes: TPanel;
    PanelGridClientes: TPanel;
    DbGridPesquisa: TDBGrid;
    DataSourcePesquisa: TDataSource;
    DataSourceEnderecos: TDataSource;
    ImageList: TImageList;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    PanelPesquisarCliente: TPanel;
    SpeedButtonAlterarCliente: TSpeedButton;
    SpeedButtonExcluirCliente: TSpeedButton;
    SpeedButtonSairClientes: TSpeedButton;
    SpeedButtonFiltrarClientes: TSpeedButton;
    SpeedButtonFiltrarTodosClientes: TSpeedButton;
    PanelBotoesEndereco: TPanel;
    SpeedButtonNovoEndereco: TSpeedButton;
    SpeedButtonAlterarEndereco: TSpeedButton;
    SpeedButtonExcluirEndereco: TSpeedButton;
    SpeedButtonFecharEndereco: TSpeedButton;
    SpeedButtonNovoCliente: TSpeedButton;
    Label3: TLabel;
    EditPesquisarCliente: TEdit;
    ComboBoxFiltroClientes: TComboBox;
    SpeedButtonPesquisar: TSpeedButton;
    PanelGridEnderecos: TPanel;
    DBGridEnderecos: TDBGrid;
    PanelClienteSelecionado: TPanel;
    Label1: TLabel;
    EditClienteSelecionado: TEdit;
    PanelPesquisarEndereco: TPanel;
    Label2: TLabel;
    SpeedButtonPesquisarEndereço: TSpeedButton;
    EditPesquisarEndereço: TEdit;
    ComboBoxFiltroEnderecos: TComboBox;
    PanelContador: TPanel;
    LabelTotRegistros: TLabel;
    EditIdClienteSelecionado: TEdit;
    PanelContadorEnd: TPanel;
    LabelTotRegistrosEnd: TLabel;
    DataSourceRelatorio: TDataSource;
{$ENDREGION}
    procedure SpeedButtonClientesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonSairClientesClick(Sender: TObject);
    procedure SpeedButtonFiltrarClientesClick(Sender: TObject);
    procedure SpeedButtonEnderecosClick(Sender: TObject);
    procedure SpeedButtonSairClick(Sender: TObject);
    procedure SpeedButtonNovoClienteClick(Sender: TObject);
    procedure SpeedButtonAlterarClienteClick(Sender: TObject);
    procedure DbGridPesquisaDblClick(Sender: TObject);
    procedure SpeedButtonExcluirClienteClick(Sender: TObject);
    procedure SpeedButtonFiltrarTodosClientesClick(Sender: TObject);
    procedure ComboBoxFiltroClientesChange(Sender: TObject);
    procedure EditPesquisarClienteChange(Sender: TObject);
    procedure SpeedButtonPesquisarClick(Sender: TObject);
    procedure SpeedButtonFiltrarEnderecosClick(Sender: TObject);
    procedure SpeedButtonNovoEnderecoClick(Sender: TObject);
    procedure SpeedButtonAlterarEnderecoClick(Sender: TObject);
    procedure DBGridEnderecosDblClick(Sender: TObject);
    procedure SpeedButtonExcluirEnderecoClick(Sender: TObject);
    procedure SpeedButtonFecharEnderecoClick(Sender: TObject);
    procedure SpeedButtonRelatoriosClick(Sender: TObject);
    procedure EditPesquisarClienteExit(Sender: TObject);
  private
    { Private declarations }
    FClasse : TClasse;
    var filtroOn, clientesAtivo : boolean;
    procedure ConfiguracoesIniciais;
    procedure HabilitarControlesCliente(aOpcao : String);
    procedure PesquisarCliente;
    procedure PesquisarEndereco;
    procedure ExcluirClientes;
    procedure ExcluirEnderecos;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;
  quantEnderecos : Integer;
  pathAnexo : string;
  excluirTodos : Boolean;
  campoIndice : String;

implementation

{$R *.dfm}

uses Biblioteca, untEnviarEmail, untClienteController, untEnderecoController, Cliente.Model,  Cliente.Endereco.Model,
  untDataModuleCadastros, untManutencaoClientes, untManutencaoEnderecos, untImportaArquivo;


procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  DataModuleCadastros := TDataModuleCadastros.Create(nil);
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  excluirTodos := False;
  filtroOn := False;
  clientesAtivo := False;
  ConfiguracoesIniciais();
  PanelClientes.Visible := False;
  PanelEndereco.Visible := False;
end;

procedure TFormPrincipal.ConfiguracoesIniciais;
begin
  HabilitarControlesCliente('opcNavegar');
end;

procedure TFormPrincipal.HabilitarControlesCliente(aOpcao : String);
begin
  if (aOpcao = 'opcNovo') or (aopcao = 'opcAlterar') then
  begin
    SpeedButtonNovoCliente.Enabled := False;
    SpeedButtonAlterarCliente.Enabled := False;
    SpeedButtonExcluirCliente.Enabled := False;
    SpeedButtonSair.Enabled := False;
  end else
  begin
    SpeedButtonNovoCliente.Enabled := True;
    SpeedButtonAlterarCliente.Enabled := True;
    SpeedButtonExcluirCliente.Enabled := True;
    SpeedButtonSair.Enabled := True;
  end;
end;

procedure TFormPrincipal.SpeedButtonClientesClick(Sender: TObject);
begin
  FClasse := clCliente;
  PanelClientes.Visible := True;
  PanelClientes.BringToFront;
  PanelEndereco.Visible := False;
  PanelEndereco.SendToBack;
  clientesAtivo := True;
  campoIndice := IfThen(ComboBoxFiltroClientes.Text = 'Nome', 'NmPrimeiro', 'FlNatureza' );
  PesquisarCliente();
end;

procedure TFormPrincipal.SpeedButtonEnderecosClick(Sender: TObject);
begin
  if clientesAtivo then
  begin
    FClasse := clEnderecos;
    filtroOn := False;
    PanelClientes.SendToBack;
    PanelEndereco.Visible := True;
    PanelEndereco.BringToFront;
    PesquisarEndereco();
    EditClienteSelecionado.Text := DataSourcePesquisa.DataSet.FieldByName('NmPrimeiro').AsString + ' ' + DataSourcePesquisa.DataSet.FieldByName('NmSegundo').AsString;
    EditIdClienteSelecionado.Text := DataSourcePesquisa.DataSet.FieldByName('IdPessoa').AsString;
    if DataSourceEnderecos.DataSet.RecordCount > 0 then
    begin
      SpeedButtonAlterarEndereco.Enabled := True;
      SpeedButtonExcluirEndereco.Enabled := True
    end else
    begin
      SpeedButtonAlterarEndereco.Enabled := False;
      SpeedButtonExcluirEndereco.Enabled := False;
    end;
    LabelTotRegistrosEnd.Caption := 'Endereços: ' + InttoStr(DataSourceEnderecos.DataSet.RecordCount);
  end
  else
     MessageDlg('Nenhum Cliente Selecionado !!', mtInformation, [mbOk], 0);

end;

procedure TFormPrincipal.SpeedButtonSairClientesClick(Sender: TObject);
begin
  excluirTodos := False;
  clientesAtivo := False;
  ConfiguracoesIniciais();
  PanelClientes.Visible := False;
  PanelEndereco.Visible := False;
end;

procedure TFormPrincipal.SpeedButtonFecharEnderecoClick(Sender: TObject);
begin
   PanelEndereco.SendToBack;
   PanelClientes.BringToFront;
end;

procedure TFormPrincipal.SpeedButtonFiltrarClientesClick(Sender: TObject);
begin
  if filtroOn then
  begin
    PanelPesquisarCliente.Visible := False;
    filtroOn := False;
  end
  else
   begin
    PanelContador.Visible := False;
    PanelPesquisarCliente.Visible := True;
    PanelContador.Visible := True;
    filtroOn := True;
  end
end;

procedure TFormPrincipal.SpeedButtonFiltrarEnderecosClick(Sender: TObject);
begin
  if filtroOn then
  begin
    PanelPesquisarEndereco.Visible := False;
    filtroOn := False;
  end
  else
   begin
    PanelContadorEnd.Visible := False;
    PanelPesquisarEndereco.Visible := True;
    PanelContadorEnd.Visible := True;
    filtroOn := True;
  end
end;

procedure TFormPrincipal.SpeedButtonFiltrarTodosClientesClick(Sender: TObject);
begin
  EditPesquisarCliente.Text := '';
  SpeedButtonFiltrarClientes.Click;
  PesquisarCliente();
end;

procedure TFormPrincipal.SpeedButtonNovoClienteClick(Sender: TObject);
begin
  if not Assigned(FormManutencaoClientes) then
    FormManutencaoClientes := TFormManutencaoClientes.Create(Self);

  FormManutencaoClientes.FOperacao := opNovo;
  FormManutencaoClientes.ShowModal;
  FreeAndNil(FormManutencaoClientes);
  DataSourcePesquisa.DataSet.Refresh;
end;

procedure TFormPrincipal.SpeedButtonAlterarClienteClick(Sender: TObject);
begin
  if not Assigned(FormManutencaoClientes) then
    FormManutencaoClientes := TFormManutencaoClientes.Create(Self);

  FormManutencaoClientes.FOperacao := opAlterar;
  FormManutencaoClientes.ShowModal;
  FreeAndNil(FormManutencaoClientes);
  DataSourcePesquisa.DataSet.Refresh;
end;

procedure TFormPrincipal.SpeedButtonAlterarEnderecoClick(Sender: TObject);
begin
  if not Assigned(FormManutencaoEnderecos) then
    FormManutencaoEnderecos := TFormManutencaoEnderecos.Create(Self);

  FormManutencaoEnderecos.LabelCliente.Caption := 'Cliente: ' + DataSourcePesquisa.DataSet.FieldByName('NmPrimeiro').AsString + ' ' + DataSourcePesquisa.DataSet.FieldByName('NmSegundo').AsString;;
  FormManutencaoEnderecos.EditIdCliente.Text := IntToStr(DataSourcePesquisa.DataSet.FieldByName('IdPessoa').AsInteger);
  FormManutencaoEnderecos.FOpcao := opcAlterar;
  FormManutencaoEnderecos.ShowModal;
  FreeAndNil(FormManutencaoEnderecos);
  DataSourcePesquisa.DataSet.Refresh;
end;

procedure TFormPrincipal.SpeedButtonExcluirClienteClick(Sender: TObject);
begin
  ExcluirClientes();
  ConfiguracoesIniciais();
  DataSourcePesquisa.DataSet.Refresh;
end;

procedure TFormPrincipal.SpeedButtonExcluirEnderecoClick(Sender: TObject);
begin
  ExcluirEnderecos();
  ConfiguracoesIniciais();
  DataSourceEnderecos.DataSet.Refresh;
  if DataSourceEnderecos.DataSet.RecordCount = 0 then
  begin
    SpeedButtonAlterarEndereco.Enabled := False;
    SpeedButtonExcluirEndereco.Enabled := False;
  end;
end;

procedure TFormPrincipal.PesquisarCliente;
var
  ClienteController : TClienteController;
begin
  ClienteController := TClienteController.Create;
  try
    ClienteController.PesquisarCliente(EditPesquisarCliente.Text, campoIndice);
  finally
    FreeAndNil(ClienteController);
  end;
  LabelTotRegistros.Caption := 'Clientes: ' + InttoStr(DataSourcePesquisa.DataSet.RecordCount);
end;

procedure TFormPrincipal.DbGridPesquisaDblClick(Sender: TObject);
begin
  SpeedButtonAlterarCliente.Click;
end;

procedure TFormPrincipal.ComboBoxFiltroClientesChange(Sender: TObject);
begin
  if ComboBoxFiltroClientes.Text = 'Nome' then
    campoIndice := 'NmPrimeiro'
  else
    campoIndice := 'FlNatureza';
end;

procedure TFormPrincipal.SpeedButtonPesquisarClick(Sender: TObject);
begin
  PesquisarCliente();
end;

procedure TFormPrincipal.SpeedButtonRelatoriosClick(Sender: TObject);
begin
  if not Assigned(FormImportaArquivo) then
    FormImportaArquivo := TFormImportaArquivo.Create(Self);

  FormImportaArquivo.ShowModal;
  FreeAndNil(FormImportaArquivo);
end;

procedure TFormPrincipal.EditPesquisarClienteChange(Sender: TObject);
begin
  if DataModuleCadastros.TbClientes.Active and (EditPesquisarCliente.Text <> '') then
    DataModuleCadastros.TbClientes.Locate(CampoIndice, EditPesquisarCliente.Text, [loPartialKey,loCaseInsensitive]);
end;

procedure TFormPrincipal.EditPesquisarClienteExit(Sender: TObject);
begin
 if DataModuleCadastros.TbClientes.Active and (EditPesquisarCliente.Text <> '') then
    DataModuleCadastros.TbClientes.Locate(CampoIndice, EditPesquisarCliente.Text, [loPartialKey,loCaseInsensitive]);
end;

procedure TFormPrincipal.ExcluirClientes;
var
  ClienteController : TClienteController;
  sErro : String;
begin
  ClienteController := TClienteController.Create;

  try
    PesquisarEndereco();
    if DataSourceEnderecos.DataSet.RecordCount > 0 then
    begin
      if MessageDlg('Existem endereço(s) associado a esse cliente, deseja excluir cliente e todos endereços asssociados ?', mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      begin
        excluirTodos := True;
        if ClienteController.ExcluirClientes(DataSourcePesquisa.DataSet.FieldByName('IdPessoa').AsInteger, sErro) = False then
          raise Exception.Create(sErro);
      end;
    end
    else
    begin
      if MessageDlg('Deseja realmente excluir o Cliente selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
        if ClienteController.ExcluirClientes(DataSourcePesquisa.DataSet.FieldByName('IdPessoa').AsInteger, sErro) = False then
          raise Exception.Create(sErro);
    end;
  finally
    FreeAndNil(ClienteController);
  end;

end;

procedure TFormPrincipal.ExcluirEnderecos;
var
  EnderecoController : TEnderecoController;
  sErro : String;
begin
  EnderecoController := TEnderecoController.Create;

  try
    begin
      if not VerificaQtdeEnderecos(DataSourceEnderecos.DataSet.FieldByName('IdPessoa').AsInteger) then
      begin
        MessageDlg('Cliente não pode ficar sem endereços !!', mtError, [mbOk], 0);
        exit
      end;
      if MessageDlg('Deseja realmente excluir o endereço selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
        if EnderecoController.ExcluirEnderecos(DataSourceEnderecos.DataSet.FieldByName('IdEndereco').AsInteger, False, 0, sErro) = False then
          raise Exception.Create(sErro);
    end;
  finally
    FreeAndNil(EnderecoController);
  end;

end;

procedure TFormPrincipal.SpeedButtonNovoEnderecoClick(Sender: TObject);
begin
  if not Assigned(FormManutencaoEnderecos) then
    FormManutencaoEnderecos := TFormManutencaoEnderecos.Create(Self);

  FormManutencaoEnderecos.LabelCliente.Caption := 'Cliente: ' + Trim(DataSourcePesquisa.DataSet.FieldByName('NMPRIMEIRO').AsString) + ' ' + Trim(DataSourcePesquisa.DataSet.FieldByName('NMSEGUNDO').AsString);
  FormManutencaoEnderecos.EditIdCliente.Text := IntToStr(DataSourcePesquisa.DataSet.FieldByName('IDPESSOA').AsInteger);
  FormManutencaoEnderecos.FOpcao := opcNovo;
  FormManutencaoEnderecos.ShowModal;
  FreeAndNil(FormManutencaoEnderecos);
  DataSourceEnderecos.DataSet.Refresh;
  SpeedButtonAlterarEndereco.Enabled := True;
  SpeedButtonExcluirEndereco.Enabled := True;
end;

procedure TFormPrincipal.PesquisarEndereco;
var
  EnderecoController : TEnderecoController;
begin
  EnderecoController := TEnderecoController.Create;

  try
    EnderecoController.PesquisarEndereco(DataSourcePesquisa.DataSet.FieldByName('IdPessoa').AsInteger);
  finally
    FreeAndNil(EnderecoController);
  end;
end;

procedure TFormPrincipal.DBGridEnderecosDblClick(Sender: TObject);
begin
  SpeedButtonAlterarEndereco.Click;
end;


procedure TFormPrincipal.SpeedButtonSairClick(Sender: TObject);
begin
  Close;
end;

end.

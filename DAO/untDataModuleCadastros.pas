unit untDataModuleCadastros;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.Win.ADODB, Data.FMTBcd, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error,FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Cliente.Model, Cliente.Endereco.Model, Cliente.EnderecoIntegracao.Model;

type
  TDataModuleCadastros = class(TDataModule)
    TbClientes: TFDQuery;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    sqlInserir: TFDQuery;
    sqlAlterar: TFDQuery;
    sqlExcluir: TFDQuery;
    TbEnderecos: TFDQuery;
    sqlRelatorio: TFDQuery;
    TbEnderecoIntegracao: TFDQuery;
    TbEnderecoIntegracaoidendereco: TIntegerField;
    TbEnderecoIntegracaodsuf: TStringField;
    TbEnderecoIntegracaonmcidade: TStringField;
    TbEnderecoIntegracaonmbairro: TStringField;
    TbEnderecoIntegracaonmlogradouro: TStringField;
    TbEnderecoIntegracaodscomplemento: TStringField;
    TbClientesidPessoa: TFDAutoIncField;
    TbClientesflnatureza: TIntegerField;
    TbClientesdsdocumento: TStringField;
    TbClientesnmprimeiro: TStringField;
    TbClientesnmsegundo: TStringField;
    TbClientesdtregistro: TSQLTimeStampField;
    TbEnderecosidPessoa: TFDAutoIncField;
    TbEnderecosflnatureza: TIntegerField;
    TbEnderecosdsdocumento: TStringField;
    TbEnderecosnmprimeiro: TStringField;
    TbEnderecosnmsegundo: TStringField;
    TbEnderecosdtregistro: TSQLTimeStampField;
    TbEnderecosidendereco: TFDAutoIncField;
    TbEnderecosdscep: TStringField;
    TbEnderecosnmlogradouro: TStringField;
    TbEnderecosdscomplemento: TStringField;
    TbEnderecosnmbairro: TStringField;
    TbEnderecosnmcidade: TStringField;
    TbEnderecosdsuf: TStringField;
    QryTmp: TFDQuery;
    MemCache: TFDMemTable;
    DsCache: TDataSource;
    FDSchemaAdapter1: TFDSchemaAdapter;
  private
    { Private declarations }

  public
    { Public declarations }
    procedure PesquisarClientes(sNome, campoIndice : String);
    procedure PesquisarEnderecos(iCodCli : Integer);
    procedure CarregarClientes(Cliente : TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodigo : Integer);
    procedure CarregarEnderecoClientes(Endereco : TClienteEndereco; iCodEnd : Integer);
    procedure CarregarEnderecoIntegracao(EnderecoIntegracao : TClienteEnderecoIntegracao; iCodEnd : Integer);
    function InserirClientes(Cliente : TCliente; Endereco : TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; out sErro : String): Boolean;
    function AlterarClientes(Cliente : TCliente; out sErro : String): Boolean;
    function ExcluirClientes(iCodigo : Integer; out sErro : String): Boolean;
    function InserirEnderecos(Endereco : TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodEnd : Integer; out sErro : String): Boolean;
    function AlterarEnderecos(Endereco : TClienteEndereco; iCodEnd : Integer; out sErro : String): Boolean;
    function AlterarEnderecoIntegracao(EnderecoIntegracao : TClienteEnderecoIntegracao; iCodEnd : Integer; out sErro : String): Boolean;
    function ExcluirEnderecos(iCodEnd : Integer; excluirTodos : Boolean; iCodigo : Integer; out sErro : String): Boolean;
  end;

var
  DataModuleCadastros: TDataModuleCadastros;

implementation

{$R *.dfm}

uses untDataModuleConexao;

{ TDataModuleCadastros }

procedure TDataModuleCadastros.PesquisarClientes(sNome, campoIndice: String);
begin
  with TbClientes do
  begin
    Close;
    Sql.Clear;
    Sql.Text := 'Select * from Pessoa where ' + campoIndice + ' like :pNome order by ' + campoIndice;
    ParamByName('pNome').AsString := sNome + '%';
    Prepared := True;
    Open();
  end;

end;

procedure TDataModuleCadastros.PesquisarEnderecos(iCodCli: Integer);
begin
  with TbEnderecos do
  begin
    Close;
    Sql.Clear;
    SQL.Add(' select PESSOA.IDPESSOA ');
    SQL.Add('       ,PESSOA.FLNATUREZA ');
    SQL.Add('       ,PESSOA.DSDOCUMENTO ');
    SQL.Add('       ,PESSOA.NMPRIMEIRO ');
    SQL.Add('       ,PESSOA.NMSEGUNDO ');
    SQL.Add('       ,PESSOA.DTREGISTRO ');
    SQL.Add('       ,ENDERECO.IDENDERECO ');
    SQL.Add('       ,ENDERECO.DSCEP ');
    SQL.Add('       ,ENDERECO_INTEGRACAO.NMLOGRADOURO ');
    SQL.Add('       ,ENDERECO_INTEGRACAO.DSCOMPLEMENTO ');
    SQL.Add('       ,ENDERECO_INTEGRACAO.NMBAIRRO ');
    SQL.Add('       ,ENDERECO_INTEGRACAO.NMCIDADE ');
    SQL.Add('       ,ENDERECO_INTEGRACAO.DSUF ');
    SQL.Add(' FROM PESSOA PESSOA ');
    SQL.Add('    INNER JOIN ENDERECO ENDERECO ON PESSOA.IDPESSOA = ENDERECO.IDPESSOA ');
    SQL.Add('    INNER JOIN ENDERECO_INTEGRACAO ENDERECO_INTEGRACAO ON ENDERECO.IDENDERECO = ENDERECO_INTEGRACAO.IDENDERECO ');
    SQL.Add(' WHERE ENDERECO.IDPESSOA = :IDPESSOA ');
    ParamByName('IDPESSOA').AsInteger := iCodCli;
    Prepared := True;
    Open();
  end;
end;

procedure TDataModuleCadastros.CarregarClientes(Cliente: TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodigo: Integer);
var
  sqlCliente : TFDQuery;
begin
  sqlCliente := TFDQuery.Create(nil);
  try
    with sqlCliente do
    begin
      Connection := DataModuleConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT  PES.IDPESSOA');
      SQL.Add(',PES.FLNATUREZA');
      SQL.Add(',PES.DSDOCUMENTO');
      SQL.Add(',PES.NMPRIMEIRO');
      SQL.Add(',PES.NMSEGUNDO');
      SQL.Add(',PES.DTREGISTRO');
      SQL.Add(',ENDC.DSCEP');
      SQL.Add(',ENDI.NMLOGRADOURO');
      SQL.Add(',ENDI.DSCOMPLEMENTO');
      SQL.Add(',ENDI.NMBAIRRO');
      SQL.Add(',ENDI.NMCIDADE');
      SQL.Add(',ENDI.DSUF');
      SQL.Add('FROM PESSOA PES');
      SQL.Add('JOIN ENDERECO ENDC ON PES.IDPESSOA = ENDC.IDPESSOA');
      SQL.Add('JOIN ENDERECO_INTEGRACAO ENDI ON ENDC.IDENDERECO = ENDI.IDENDERECO');
      SQL.Add('WHERE PES.IDPESSOA = :IdPessoa');
      ParamByName('IdPessoa').AsInteger := iCodigo;
      Open;

      Cliente.IdPessoa := FieldByName('IDPESSOA').AsInteger;
      Cliente.FlNatureza := FieldByName('FLNATUREZA').AsInteger;
      Cliente.DsDocumento := FieldByName('DSDOCUMENTO').AsString;
      Cliente.NmPrimeiro := FieldByName('NMPRIMEIRO').AsString;
      Cliente.NmSegundo := FieldByName('NMSEGUNDO').AsString;
      Cliente.DtRegistro := FieldByName('DTREGISTRO').AsDateTime;
      Endereco.DsCep := FieldByName('DSCEP').AsString;

      with EnderecoIntegracao do
      begin
        EnderecoIntegracao.NmLogradouro := FieldByName('NMLOGRADOURO').AsString;
        EnderecoIntegracao.DsComplemento := FieldByName('DSCOMPLEMENTO').AsString;
        EnderecoIntegracao.NmBairro := FieldByName('NMBAIRRO').AsString;
        EnderecoIntegracao.NmCidade := FieldByName('NMCIDADE').AsString;
        EnderecoIntegracao.DsUf := FieldByName('DSUF').AsString;
      end;
    end;
  finally
    FreeAndNil(sqlCliente);
  end;
end;

procedure TDataModuleCadastros.CarregarEnderecoClientes(Endereco: TClienteEndereco; iCodEnd: Integer);
var sqlEndereco : TFDQuery;
begin
  sqlEndereco := TFDQuery.Create((nil));
  try
    with sqlEndereco do
    begin
      Connection := DataModuleConexao.FDConnection;
      SQL.Text := 'Select * from Endereco where IdEndereco = ' + IntToStr(iCodEnd);
      Open;

      Endereco.IdEndereco := FieldByName('IdEndereco').AsInteger;
      Endereco.IdPessoa := FieldByName('IdPessoa').AsInteger;
      Endereco.DsCep := FieldByName('DsCep').AsString;
     end;
  finally
    FreeAndNil(sqlEndereco);
  end;
end;

procedure TDataModuleCadastros.CarregarEnderecoIntegracao(EnderecoIntegracao: TClienteEnderecoIntegracao; iCodEnd: Integer);
var sqlEnderecoInt : TFDQuery;
begin
  sqlEnderecoInt := TFDQuery.Create((nil));
  try
    with sqlEnderecoInt do
    begin
      Connection := DataModuleConexao.FDConnection;
      SQL.Text := 'Select * from Endereco_Integracao where IdEndereco = ' + IntToStr(iCodEnd);
      Open;

      EnderecoIntegracao.IdEndereco := FieldByName('IDENDERECO').AsInteger;
      EnderecoIntegracao.NmLogradouro := FieldByName('NMLOGRADOURO').AsString;
      EnderecoIntegracao.DsComplemento := FieldByName('DSCOMPLEMENTO').AsString;
      EnderecoIntegracao.NmBairro := FieldByName('NMBAIRRO').AsString;
      EnderecoIntegracao.NmCidade := FieldByName('NMCIDADE').AsString;
      EnderecoIntegracao.DsUf := FieldByName('DSUF').AsString;
    end;
  finally
    FreeAndNil(sqlEnderecoInt);
  end;
end;

function TDataModuleCadastros.InserirClientes(Cliente: TCliente; Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; out sErro: String): Boolean;
var codCliente, codEndereco : Integer;
    QryTmp, QryEnd, QryInt : TFDQuery;
begin
  QryTmp := TFDQuery.Create((nil));
  QryEnd := TFDQuery.Create((nil));
  QryInt := TFDQuery.Create((nil));
  QryTmp.Connection := DataModuleConexao.FDConnection;
  QryEnd.Connection := DataModuleConexao.FDConnection;
  QryInt.Connection := DataModuleConexao.FDConnection;

  with sqlInserir, Cliente do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Pessoa (FlNatureza, DsDocumento, NmPrimeiro, NmSegundo, DtRegistro ) ' );
    SQL.Add('VALUES (:FlNatureza, :DsDocumento, :NmPrimeiro, :NmSegundo, :DtRegistro ) ');

    ParamByName('FlNatureza').AsInteger := FlNatureza;
    ParamByName('DsDocumento').AsString := DsDocumento;
    ParamByName('NmPrimeiro').AsString := NmPrimeiro;
    ParamByName('NmSegundo').AsString := NmSegundo;
    ParamByName('DtRegistro').AsDateTime := DtRegistro;

    try
      Prepared := True;
      ExecSQL;
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao inserir um novo cliente !' + sLineBreak + E.Message;
        result := False;
      end;
    end;

    QryTmp.Close;
    QryTmp.SQL.Clear;
    QryTmp.SQL.Add('SELECT MAX(idpessoa) as UltIdPessoa FROM Pessoa ' );
    QryTmp.Open;
    codCliente := QryTmp.FieldByName('UltIdPessoa').AsInteger;

    with QryEnd do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO Endereco (IdPessoa, DsCEP) VALUES (:Id, :DsCep) ');
      ParamByName('Id').asInteger := codCliente;
      ParamByName('DsCep').AsString := Endereco.DsCep;
      try
        Prepared := True;
        ExecSQL;
        Result := True;
      except on E: Exception do
        begin
          sErro := 'Ocorreu um erro ao inserir um endereço do cliente !' + sLineBreak + E.Message;
          result := False;
        end;
      end;
    end;


    //QryEnd.ExecSQL;

    QryTmp.Close;
    QryTmp.SQL.Clear;
    QryTmp.SQL.Add('SELECT IdEndereco FROM Endereco ' );
    QryTmp.SQL.Add('WHERE IdPessoa = :idPessoa ' );
    QryTmp.ParamByName('IdPessoa').AsInteger := codcliente;
    QryTmp.Open;
    codEndereco := QryTmp.FieldByName('IdEndereco').AsInteger;

    with QryInt do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO endereco_integracao (IdEndereco, DsUf, NmCidade, NmBairro, NmLogradouro, DsComplemento )');
      SQL.Add('VALUES (:IdEndereco, :DsUf, :NmCidade, :NmBairro, :NmLogradouro, :DsComplemento )');
      ParamByName('IdEndereco').asInteger := codEndereco;
      ParamByName('DsUf').AsString := EnderecoIntegracao.DsUf;
      ParamByName('NmCidade').AsString := EnderecoIntegracao.NmCidade;
      ParamByName('NmBairro').AsString := EnderecoIntegracao.NmBairro;
      ParamByName('NmLOgradouro').AsString := EnderecoIntegracao.NmLogradouro;
      ParamByName('DsComplemento').AsString := EnderecoIntegracao.DsComplemento;
      try
        Prepared := True;
        ExecSQL;
        Result := True;
      except on E: Exception do
        begin
          sErro := 'Ocorreu um erro ao inserir o endereço integrado do cliente !' + sLineBreak + E.Message;
          result := False;
        end;
      end;
    end;
  end;
  QryTmp.Free;
  QryEnd.Free;
  QryInt.Free;
end;

function TDataModuleCadastros.InserirEnderecos(Endereco: TClienteEndereco; EnderecoIntegracao: TClienteEnderecoIntegracao; iCodEnd: Integer; out sErro: String): Boolean;
var codEndereco : Integer;
    QryTmp, QryInt : TFDQuery;
begin
  QryTmp := TFDQuery.Create((nil));
  QryInt := TFDQuery.Create((nil));
  QryTmp.Connection := DataModuleConexao.FDConnection;
  QryInt.Connection := DataModuleConexao.FDConnection;
  with sqlInserir, Endereco do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Endereco (IdPessoa, DsCEP) VALUES (:Id, :DsCep) ');

    ParamByName('Id').asInteger := iCodEnd;
    ParamByName('DsCep').AsString := DsCep;

    try
      Prepared := True;
      ExecSQL;
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao inserir um novo endereco do cliente !' + sLineBreak + E.Message;
        Result := False;
      end;
    end;

    QryTmp.Close;
    QryTmp.SQL.Clear;
    QryTmp.SQL.Add('SELECT MAX(idendereco) as UltIdEndereco FROM endereco where idpessoa = :idPessoa ' );
    QryTmp.ParamByName('IdPessoa').AsInteger := iCodEnd;
    QryTmp.Open;
    codEndereco := QryTmp.FieldByName('UltIdEndereco').AsInteger;

    with QryInt do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO endereco_integracao (IdEndereco, DsUf, NmCidade, NmBairro, NmLogradouro, DsComplemento )');
      SQL.Add('VALUES (:IdEndereco, :DsUf, :NmCidade, :NmBairro, :NmLogradouro, :DsComplemento )');
      ParamByName('IdEndereco').asInteger := codEndereco;
      ParamByName('DsUf').AsString := EnderecoIntegracao.DsUf;
      ParamByName('NmCidade').AsString := EnderecoIntegracao.NmCidade;
      ParamByName('NmBairro').AsString := EnderecoIntegracao.NmBairro;
      ParamByName('NmLOgradouro').AsString := EnderecoIntegracao.NmLogradouro;
      ParamByName('DsComplemento').AsString := EnderecoIntegracao.DsComplemento;
      try
        Prepared := True;
        ExecSQL;
        Result := True;
      except on E: Exception do
        begin
          sErro := 'Ocorreu um erro ao inserir o endereço integrado do cliente !' + sLineBreak + E.Message;
          result := False;
        end;
      end;
    end;
  end;
  QryTmp.Free;
  QryInt.Free;
end;

function TDataModuleCadastros.AlterarClientes(Cliente: TCliente;  out sErro: String): Boolean;
begin
  with sqlAlterar, Cliente do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'update Pessoa set FlNatureza = :FlNatureza, ' +
                'DsDocumento = :DsDocumento, ' +
                'NmPrimeiro = :NmPrimeiro, ' +
                'NmSegundo = :NmSegundo, ' +
                'DtRegistro = :DtRegistro, ' +
                'where IdPessoa = :Id' ;
    ParamByName('FlNatureza').AsInteger := FlNatureza;
    ParamByName('DsDocumento').AsString := DsDocumento;
    ParamByName('NmPrimeiro').AsString := NmPrimeiro;
    ParamByName('NmSegundo').AsString := NmSegundo;
    ParamByName('DtRegistro').AsDate := DtRegistro;
    ParamByName('Id').AsInteger := IdPessoa;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar os dados do cliente !' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDataModuleCadastros.AlterarEnderecos(Endereco: TClienteEndereco; iCodEnd: Integer; out sErro: String): Boolean;
begin
  with sqlAlterar, Endereco do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'update Endereco set DsCep = :DsCep ' +
                'where IdEndereco = :Id' ;
    ParamByName('DsCep').AsString := DsCep;
    ParamByName('Id').AsInteger := IdEndereco;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar o endereco deste cliente !' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDataModuleCadastros.AlterarEnderecoIntegracao(EnderecoIntegracao: TClienteEnderecoIntegracao; iCodEnd: Integer; out sErro: String): Boolean;
begin
  with sqlAlterar, EnderecoIntegracao do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update Endereco_Integracao set DsUf = :DsUf, ');
    SQL.Add('NmCidade = :NmCidade, ');
    SQL.Add('NmBairro = :NmBairro, ');
    SQL.Add('NmLogradouro = :NmLogradouro, ');
    SQL.Add('DsComplemento = :DsComplemento ');
    SQL.Add('where IdEndereco = :Id');
    ParamByName('DsUf').AsString := DsUf;
    ParamByName('NmCidade').AsString := NmCidade;
    ParamByName('NmBairro').AsString := NmBairro;
    ParamByName('NmLogradouro').AsString := NmLogradouro;
    ParamByName('DsComplemento').AsString := DsComplemento;
    ParamByName('Id').AsInteger := iCodEnd;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar o endereco deste cliente !' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;

end;

function TDataModuleCadastros.ExcluirClientes(iCodigo: Integer;  out sErro: String): Boolean;
begin
  with sqlExcluir do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'delete from Pessoa where IdPessoa = :Id';
    ParamByName('Id').AsInteger := iCodigo;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao excluir o cliente !' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDataModuleCadastros.ExcluirEnderecos(iCodEnd: Integer; excluirTodos : Boolean; iCodigo : Integer; out sErro: String): Boolean;
begin
  with sqlExcluir do
  begin
    Close;
    SQL.Clear;
    if excluirTodos then
    begin
      SQL.Add('delete from Endereco where IdCliente = :Id');
      ParamByName('Id').AsInteger := iCodigo;

      try
        Prepared := True;
        ExecSQL();
        Result := True
      except on E: Exception do
        begin
          sErro := 'Ocorreu um erro ao excluir o(s) endereço(s) do cliente !' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end
    else
    begin
      SQL.Add('delete from Endereco_Integracao  where IdEndereco = :Id');
      ParamByName('Id').AsInteger := iCodEnd;

      try
      Prepared := True;
      ExecSQL();
      Result := True

      except on E: Exception do
        begin
          sErro := 'Ocorreu um erro ao excluir o endereço integração do cliente !' + sLineBreak + E.Message;
          Result := False;
          exit
        end;
      end;

      Sql.Clear;
      SQL.Add('delete from Endereco where IdEndereco = :Id');
      ParamByName('Id').AsInteger := iCodEnd;

      try
        Prepared := True;
        ExecSQL();
        Result := True
      except on E: Exception do
        begin
          sErro := 'Ocorreu um erro ao excluir o endereço do cliente !' + sLineBreak + E.Message;
          Result := False;
        end;
      end;
    end;
  end;
end;


end.

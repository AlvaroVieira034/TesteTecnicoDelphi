unit Biblioteca;

interface

uses System.SysUtils, REST.Client, REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, IdHTTP,

  //Units Necessárias
  IniFiles,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdBaseComponent,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdAttachmentFile,
  IdText;

type
  TDadosCep = Record
     sucesso: boolean;
     msg: string;
     cep: string;
     logradouro: string;
     complemento: string;
     bairro: string;
     localidade: string;
     uf: string;
     ibge: string;
     gia: string;
     ddd: string;
     siafi: string;
     jsonCompleto: string;
  End;

  const BaseURLCep = 'http://viacep.com.br/ws';

  function CarregarCep(cep: String): TDadosCep;
  function CarregarCepIndy(cep: String): TDadosCep;
  function JsonFieldToString(nomeCampo: string; jsonBusca: TJSonValue): string;
  function SoNumeros(str: string): string;
  function VerificaQtdeEnderecos(cliente: integer): boolean;

implementation

uses untMsgAguarde, FireDAC.Comp.Client, untDataModuleConexao;

function CarregarCep(cep: String): TDadosCep;
var
   json: TJSonValue;

   RESTClient   : TRESTClient;
   RESTRequest  : TRESTRequest;
   RESTResponse : TRESTResponse;
begin
   Result.sucesso := False;

   if trim(cep) = EmptyStr then
      exit;

   RESTClient := TRESTClient.Create(nil);
   RESTRequest := TRESTRequest.Create(nil);
   RESTResponse := TRESTResponse.Create(nil);
   try
       RESTClient.BaseURL := BaseURLCep;
       RESTClient.Accept  := 'application/json';
       RESTClient.AcceptCharSet := 'UTF-8';
       RESTClient.ContentType   := 'application/json';

       RESTRequest.Method := TRESTRequestMethod.rmGET;
       RESTRequest.Client := RESTClient;

       RESTRequest.Response := RESTResponse;
       RESTRequest.Accept := 'application/json';
       RESTRequest.Resource := cep + '/json';
       RESTRequest.Execute;
       try
           if RESTResponse.StatusCode <> 200 then
           begin
              Result.sucesso := False;
              Result.msg := 'CEP não localizado';
              exit;
           end;

           Result.jsonCompleto := RESTResponse.Content;

           if Result.jsonCompleto = EmptyStr then
           begin
              Result.sucesso := False;
              Result.msg := 'Não foi possível obter o retorno';
              exit;
           end;

           json := TJSonObject.ParseJSONValue(Result.jsonCompleto);
           try
              Result.cep :=  JsonFieldToString('cep',  json);
              Result.logradouro :=  JsonFieldToString('logradouro',  json);
              Result.complemento :=  JsonFieldToString('complemento',  json);
              Result.bairro :=  JsonFieldToString('bairro',  json);
              Result.localidade :=  JsonFieldToString('localidade',  json);
              Result.uf :=  JsonFieldToString('uf',  json);
              Result.ibge :=  JsonFieldToString('ibge', json);
              Result.gia :=  JsonFieldToString('gia', json);
              Result.ddd :=  JsonFieldToString('ddd',  json);
              Result.siafi :=  JsonFieldToString('siafi', json);
              Result.sucesso := True;

              if trim(Result.logradouro) = EmptyStr then
              begin
                Result.msg := 'CEP não localizado.';
                Result.sucesso := False;
              end;
           finally
              FreeAndNil(json);
           end;
       except on E: Exception do
         begin
            Result.sucesso := False;
            Result.msg := 'Ocorreu um  erro ao consultar o cep. Erro:' + E.Message;
         end;
       end;
   finally
      FreeAndNil(RESTClient);
      FreeAndNil(RESTRequest);
      FreeAndNil(RESTResponse);
   end;
end;

// Acessando WebService Utilizando Indy
function CarregarCepIndy(cep: String): TDadosCep;
var
   json: TJSonValue;
   lHTTP: TIdHTTP;
begin
   Result.sucesso := False;

   if trim(cep) = EmptyStr then
      exit;

   try
       lHTTP := TIdHTTP.Create;
       try
         Result.jsonCompleto := lHTTP.Get(BaseURLCep + '/' + cep + '/json');

         if Result.jsonCompleto = EmptyStr then
         begin
            Result.sucesso := False;
            Result.msg := 'Não foi possível obter o retorno';
            exit;
         end;

         json := TJSonObject.ParseJSONValue(Result.jsonCompleto);
         try
            Result.cep :=  JsonFieldToString('cep',  json);
            Result.logradouro :=  JsonFieldToString('logradouro',  json);
            Result.complemento :=  JsonFieldToString('complemento',  json);
            Result.bairro :=  JsonFieldToString('bairro',  json);
            Result.localidade :=  JsonFieldToString('localidade',  json);
            Result.uf :=  JsonFieldToString('uf',  json);
            Result.ibge :=  JsonFieldToString('ibge', json);
            Result.gia :=  JsonFieldToString('gia', json);
            Result.ddd :=  JsonFieldToString('ddd',  json);
            Result.siafi :=  JsonFieldToString('siafi', json);
            Result.sucesso := True;

            if trim(Result.logradouro) = EmptyStr then
            begin
               Result.msg := 'CEP não localizado.';
               Result.sucesso := False;
            end;
         finally
            FreeAndNil(json);
         end;
       except on E: Exception do
         begin
            Result.sucesso := False;
            Result.msg := 'Ocorreu um  erro ao consultar o cep. Erro:' + E.Message;
         end;
       end;
   finally
      FreeAndNil(lHTTP)
   end;
end;

function JsonFieldToString(nomeCampo: string; jsonBusca: TJSonValue): string;
begin
  try
    Result := jsonBusca.GetValue<string>(nomeCampo);
  except on E: Exception do
    Result := '';
  end;
end;

function SoNumeros(str: string): string;
var
i: Integer;
d1: string;
begin
  for i := 1 to Length(str) do
  begin
    if Pos(Copy(str, i, 1), '/-.') = 0 then
    d1 := d1 + Copy(str, i, 1);
  end;
  Result := d1;
end;

function VerificaQtdeEnderecos(cliente: integer): boolean;
var QryQtdEnd : TFDQuery;
begin
  Result := False;
  QryQtdEnd := TFDQuery.Create((nil));
  QryQtdEnd.Connection := DataModuleConexao.FDConnection;
  with QryQtdEnd do
  begin
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) as QtdEnd FROM Endereco where IdPessoa = :IdPessoa ');
    ParamByName('IdPessoa').asInteger := cliente;

    Prepared := True;
    Open;

    if FieldByName('QtdEnd').AsInteger > 1 then
      Result := True;

    Free;
  end;
end;

end.

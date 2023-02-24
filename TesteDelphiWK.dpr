program TesteDelphiWK;

uses
  Vcl.Forms,
  Biblioteca in 'Lib\Biblioteca.pas',
  untDataModuleConexao in 'DAO\untDataModuleConexao.pas' {DataModuleConexao: TDataModule},
  untDataModuleCadastros in 'DAO\untDataModuleCadastros.pas' {DataModuleCadastros: TDataModule},
  Cliente.Model in 'Model\Cliente.Model.pas',
  Cliente.Endereco.Model in 'Model\Cliente.Endereco.Model.pas',
  untClienteController in 'Controller\untClienteController.pas',
  untEnderecoController in 'Controller\untEnderecoController.pas',
  untPrincipal in 'View\untPrincipal.pas' {FormPrincipal},
  untManutencaoPadrao in 'View\untManutencaoPadrao.pas' {FormManutencaoPadrao},
  untManutencaoClientes in 'View\untManutencaoClientes.pas' {FormManutencaoClientes},
  untFormat in 'Lib\untFormat.pas',
  untManutencaoEnderecos in 'View\untManutencaoEnderecos.pas' {FormManutencaoEnderecos},
  untMsgAguarde in 'View\untMsgAguarde.pas' {FormMsgAguarde},
  untEnviarEmail in 'View\untEnviarEmail.pas' {FormEnviarEmail},
  Cliente.EnderecoIntegracao.Model in 'Model\Cliente.EnderecoIntegracao.Model.pas',
  untImportaArquivo in 'View\untImportaArquivo.pas' {FormImportaArquivo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.

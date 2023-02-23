object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  Height = 242
  Width = 369
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=testedelphiwk'
      'User_Name=postgres'
      'Password=info'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorHome = 'D:\Treinamento\Delphi\Testes Vagas\Teste DelphiWK'
    Left = 184
    Top = 24
  end
  object FDConnectionFB: TFDConnection
    Params.Strings = (
      'SERVER=PC-ALVARO\SQLEXPRESS'
      'User_Name=sa'
      'Password=info'
      'ApplicationName=Architect'
      'Workstation=PC-ALVARO'
      'MARS=yes'
      'Database=TesteDelphiWK'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 280
    Top = 120
  end
end

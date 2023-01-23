object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  Height = 242
  Width = 369
  object FDConnection: TFDConnection
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
    Left = 32
    Top = 24
  end
end

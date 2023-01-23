object DataModuleCadastros: TDataModuleCadastros
  OldCreateOrder = False
  Height = 331
  Width = 807
  object TbClientes: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      'select * from pessoa'
      ''
      '')
    Left = 64
    Top = 24
    object TbClientesidPessoa: TFDAutoIncField
      FieldName = 'idPessoa'
      Origin = 'idPessoa'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TbClientesflnatureza: TIntegerField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
      Required = True
    end
    object TbClientesdsdocumento: TStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object TbClientesnmprimeiro: TStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object TbClientesnmsegundo: TStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object TbClientesdtregistro: TSQLTimeStampField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 696
    Top = 40
  end
  object sqlInserir: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      
        'INSERT INTO pessoa (flnatureza, dsdocumento, nmprimeiro, nmsegun' +
        'do, dtregisto) '
      
        'values (:flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dtr' +
        'egisto)')
    Left = 184
    Top = 16
    ParamData = <
      item
        Name = 'FLNATUREZA'
        ParamType = ptInput
      end
      item
        Name = 'DSDOCUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'NMPRIMEIRO'
        ParamType = ptInput
      end
      item
        Name = 'NMSEGUNDO'
        ParamType = ptInput
      end
      item
        Name = 'DTREGISTO'
        ParamType = ptInput
      end>
  end
  object sqlAlterar: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      'update pessoa'
      'set Flnatureza= :Flnatureza, '
      '     DsDocumento = :DsDocumento,'
      '     NmPrimeiro = :NmPrimeiro'
      '     NmSegundo = :NmSegundo'
      '     DtRegistro = :DtRegistro'
      'where IdPessoa = :Id')
    Left = 184
    Top = 72
    ParamData = <
      item
        Name = 'FLNATUREZA'
        ParamType = ptInput
      end
      item
        Name = 'DSDOCUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'NMPRIMEIRO'
        ParamType = ptInput
      end
      item
        Name = 'NMSEGUNDO'
        ParamType = ptInput
      end
      item
        Name = 'DTREGISTRO'
        ParamType = ptInput
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object sqlExcluir: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      'delete from pessoa'
      'where IdPessoa = :Id')
    Left = 184
    Top = 136
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object TbEnderecos: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      'select pessoa.idPessoa'
      '      ,pessoa.flnatureza'
      '      ,pessoa.dsdocumento'
      '      ,pessoa.nmprimeiro'
      '      ,pessoa.nmsegundo'
      '      ,pessoa.dtregistro'
      '      ,endereco.idendereco'
      '      ,endereco.dscep'
      '      ,endereco_integracao.nmlogradouro'
      '      ,endereco_integracao.dscomplemento'
      '      ,endereco_integracao.nmbairro'
      '      ,endereco_integracao.nmcidade'
      '      ,endereco_integracao.dsuf'
      'from pessoa pessoa'
      
        '  inner join endereco endereco on pessoa.idpessoa = endereco.idp' +
        'essoa'
      
        '  inner join endereco_integracao endereco_integracao on endereco' +
        '.idendereco = endereco_integracao.idendereco'
      '')
    Left = 64
    Top = 88
    object TbEnderecosidPessoa: TFDAutoIncField
      FieldName = 'idPessoa'
      Origin = 'idPessoa'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TbEnderecosflnatureza: TIntegerField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
      Required = True
    end
    object TbEnderecosdsdocumento: TStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object TbEnderecosnmprimeiro: TStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object TbEnderecosnmsegundo: TStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object TbEnderecosdtregistro: TSQLTimeStampField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
    object TbEnderecosidendereco: TFDAutoIncField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ReadOnly = True
    end
    object TbEnderecosdscep: TStringField
      FieldName = 'dscep'
      Origin = 'dscep'
      Required = True
      Size = 15
    end
    object TbEnderecosnmlogradouro: TStringField
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object TbEnderecosdscomplemento: TStringField
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
    object TbEnderecosnmbairro: TStringField
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object TbEnderecosnmcidade: TStringField
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object TbEnderecosdsuf: TStringField
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
  end
  object sqlRelatorio: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      'select Pessoa.*, Endereco.*, '
      'from pessoa'
      'left join Endereco on Pessoa.IdPessoa = Endereco.IdPessoa'
      'order by Pessoa.Nome')
    Left = 184
    Top = 200
  end
  object TbEnderecoIntegracao: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      'select * from endereco_integracao'
      'where IdEndereco = :IdEndereco')
    Left = 64
    Top = 160
    ParamData = <
      item
        Name = 'IDENDERECO'
        ParamType = ptInput
      end>
    object TbEnderecoIntegracaoidendereco: TIntegerField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TbEnderecoIntegracaodsuf: TStringField
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
    object TbEnderecoIntegracaonmcidade: TStringField
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object TbEnderecoIntegracaonmbairro: TStringField
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object TbEnderecoIntegracaonmlogradouro: TStringField
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object TbEnderecoIntegracaodscomplemento: TStringField
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
  end
  object QryTmp: TFDQuery
    Connection = DataModuleConexao.FDConnection
    SQL.Strings = (
      'SELECT IdPessoa FROM Pessoa WHERE IdPessoa = SCOPE_IDENTITY()')
    Left = 280
    Top = 24
  end
  object MemCache: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 264
  end
  object DsCache: TDataSource
    Left = 120
    Top = 264
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 208
    Top = 264
  end
end

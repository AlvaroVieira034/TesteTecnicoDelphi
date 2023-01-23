inherited FormManutencaoClientes: TFormManutencaoClientes
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 406
  ClientWidth = 781
  Position = poOwnerFormCenter
  OnShow = FormShow
  ExplicitWidth = 787
  ExplicitHeight = 435
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBotoes: TPanel
    Left = 644
    Height = 406
    ExplicitLeft = 634
    ExplicitHeight = 396
    inherited SpeedButtonGravar: TSpeedButton
      OnClick = SpeedButtonGravarClick
    end
    inherited SpeedButtonFechar: TSpeedButton
      Top = 356
      ExplicitTop = 311
    end
    inherited SpeedButtonCancelar: TSpeedButton
      OnClick = SpeedButtonCancelarClick
    end
  end
  inherited PanelDados: TPanel
    Width = 644
    Height = 406
    ExplicitWidth = 634
    ExplicitHeight = 396
    object GroupBoxClientes: TGroupBox
      Left = 7
      Top = 3
      Width = 617
      Height = 385
      Caption = ' Dados do Cliente '
      TabOrder = 0
      object Label1: TLabel
        Left = 35
        Top = 54
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object LabelDocumento: TLabel
        Left = 8
        Top = 83
        Width = 58
        Height = 13
        Caption = 'Documento:'
      end
      object Label4: TLabel
        Left = 395
        Top = 54
        Width = 58
        Height = 13
        Caption = 'Sobrenome:'
      end
      object Label13: TLabel
        Left = 52
        Top = 26
        Width = 14
        Height = 13
        Caption = 'Id:'
        Enabled = False
      end
      object Label3: TLabel
        Left = 393
        Top = 26
        Width = 60
        Height = 13
        Caption = 'Tipo Cliente:'
      end
      object Label5: TLabel
        Left = 387
        Top = 83
        Width = 70
        Height = 13
        Caption = 'Data Registro:'
      end
      object EditNome: TEdit
        Left = 72
        Top = 52
        Width = 199
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object EditDocumento: TEdit
        Left = 72
        Top = 82
        Width = 199
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnChange = EditDocumentoChange
      end
      object EditSobrenome: TEdit
        Left = 461
        Top = 52
        Width = 146
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object ComboBoxTipoPessoa: TComboBox
        Left = 461
        Top = 23
        Width = 146
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Text = 'Selecione ...'
        OnChange = ComboBoxTipoPessoaChange
        Items.Strings = (
          'Selecione ...'
          'Pessoa F'#237'sica'
          'Pessoa Jur'#237'dica')
      end
      object EditId: TEdit
        Left = 72
        Top = 23
        Width = 54
        Height = 19
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object EditDataRegistro: TEdit
        Left = 461
        Top = 82
        Width = 146
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnKeyPress = EditDataRegistroKeyPress
      end
      object GroupBoxEnderecos: TGroupBox
        Left = 10
        Top = 107
        Width = 597
        Height = 272
        Caption = ' Endere'#231'os '
        TabOrder = 6
        DesignSize = (
          597
          272)
        object Label2: TLabel
          Left = 53
          Top = 21
          Width = 23
          Height = 13
          Caption = 'CEP:'
        end
        object SpeedButtonAdiciona: TSpeedButton
          Left = 480
          Top = 16
          Width = 99
          Height = 27
          Anchors = [akLeft, akTop, akRight]
          BiDiMode = bdRightToLeftNoAlign
          Caption = ' &Adiciona'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000BB8A5EBB8A5E
            BB8A5EBB8A5EBB8A5EBB8A5EBD8E63E7D5C6FBFDFCADD4B26DB07657A3616AAA
            71AACDADFBFDFBFFFFFFBC8B5EFFFFFEFFFCF7FFFEF5FFFEF6FFFBF4FFFAF5F9
            FCFA85C38F62B57266B77559AD6764B4735EAB6B7EB483F9FBF9BE8C5EFFFFFE
            FFFCF7FFFEF5FFFEF6FFFBF4FFFDFBAFDAB764B97569C0796AB474D2E8D568B3
            7465BA775EAB6BA9CDACBF8E5FFFFFFE7B432BFFFFF57B432B7B432BECE4E16F
            BE7F6ABD796EB8789DCFA4FFFFFF9CCDA46BB47766B57464A56BC18F5FFFFDFA
            FFFFFCFFFFFCFFFFFCFFFFFCFFFFFF60BA735EB36BD3EAD6FFFFFFFFFFFFFFFF
            FFD2E8D559AD6754A05DC39160FFFFFC7B432BFFFFF57B432B7B432BECE4E172
            C2826CBD7A6FB9799FD0A5FFFFFF9DCFA46DB67766B77566AA6FC49260FFFFFC
            FFFDF7FFFFF5FFFFFFFFFFFFFFFEFDAFDDB968BF7B6DC47B6CB877D3EAD66CB6
            7668C07962B270AAD0AEC79361FFFEF67B432BFFFFF57B432B7B432BBB9E91F9
            FDFA89CD9767BE796BBD795EB36B6ABB7863B57382BE8BF9FCF9C89561FFFFFB
            FFFFF5FFFFF5FFFFF5FFFFF5FFFFF5FFFFFBFBFEFCB2DEBB75C28561B87273BD
            80AFD8B6FBFDFCFFFFFFCA9662FFFFFC7B432BF7F2E87B432B7B432B7B432BFF
            FFFCB29284DDCFC9EBE2DFEBE2DFFFFEFCEEE1D6FFFFFFFFFFFFCC9862FFFBF8
            FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFF3EAFFF9
            F3BB8A5EFFFFFFFFFFFFCD9963FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFF
            FFFCFFFFFCFFFFFCDDDBDADDDBDADDDBDABB8A5EFFFFFFFFFFFFCF9A63FFFBF8
            FFF9F3FFF9F30000A10000A10000A10000A100009EFFFFFFDDDBDADDDBDAF5F7
            F8BB8A5EFFFFFFFFFFFFD09C64FFFBF8FEF5EFFFFFF5FFFFF5FFFFF5FFFFF5FF
            FFF5FFFFF5FFFFF5E9E5D5F9FCFDE7D7CAD4B7A0FFFFFFFFFFFFD29D64FFFFFF
            FFFBF8FFFBF8FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFEEEEEEEDE0D8CBA9
            8EF8F4F1FFFFFFFFFFFFD4A067D19C64CF9A63CC9862CA9662C89461C49260C2
            9060BF8E5FBD8C5EC2976FCEAD93F8F4F1FFFFFFFFFFFFFFFFFF}
          ParentFont = False
          ParentBiDiMode = False
          OnClick = SpeedButtonGravarClick
          ExplicitWidth = 107
        end
        object SpeedButtonPesquisaCep: TSpeedButton
          Left = 192
          Top = 18
          Width = 24
          Height = 24
          Hint = 'Digite o CEP e clique para importar os dados do endere'#231'o'
          Anchors = [akLeft, akTop, akRight]
          BiDiMode = bdRightToLeftNoAlign
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFAFAFAF9
            F9F9F9F9F9F8F8F8F9F9F9F9F9F9C2C2C26B6E6D6A6D6CCDCECDFFFFFFFFFFFF
            FFFFFFFFFFFFD1D2D2A8ABAA6F7472696E6CA8ABAAD1D2D2FFFFFFB1B1B16A6D
            6CCACBCBD6D6D66A6D6CFFFFFFFFFFFFE9EAEA787C7A8F91919C9D9CC5C5C5DF
            DFDF9B9C9B747876C0C0C06B6E6DB5B7B7888B89C7C7C76A6D6CFFFFFFE9EAEA
            6E73719D9E9DE9E2DBD2B396CDA179CE9F72D3B497E4DCD5696C6BB7B8B88487
            85737775717573E3E4E3FFFFFF767A78AEAFAEDCCAB9CE9F72C19B7AE6D1BDDD
            BFA3BD997ACE9F73D2CCC59295938A8C8B6E7170EEEFEEFFFFFFD0D2D18F9290
            E1D9D1CE9F72E1C4A9E9D2BDEDDAC9E6CEB8EFDFD0E4CDB8CE9F72E0D9D27275
            74B9BBBAFFFFFFFFFFFF9CA09EC5C5C5CBA786D2AC8BE5CAB2E9D3BEEEDCCBEA
            D4C0F0E1D4ECD9C8CBA789CBAA8ACACACAA1A4A2FFFFFFFFFFFF6C716FDFDFDF
            CDA077E4C8B0EDDCCBF2E4D8F2E5D9EAD5C3EEDDCDEBD6C4E7CEB8CA9B70DBDB
            DB6D716FFFFFFFFFFFFF6C716FDBDAD8CE9E71EBD6C3F0E2D5F3E8DDF4EBE1F2
            E5D9EBD6C5E8D1BCE5CAB2CE9E71E2E2E26C716FFFFFFFFFFFFF666B69D9DADA
            BF9066E3C7AEF1E4DAF4E9E0F4EBE4F3E9E0EEDFD1DBB594D4A880CAA381D8D9
            D9666B69FFFFFFFFFFFFC1C3C2A8AAA9C5B1A0CE9F73F2E5DAF8EFE9F8F3EDF5
            EBE3F2E4D7E4C9B0CE9E72CBBCAFA4A7A6C6C8C7FFFFFFFFFFFFFFFFFF707472
            DADADAC6A88CCF9F73ECDBCBF6EDE4F3E9DFE7CFB8CEA073C6AA91DBDBDB7074
            72FFFFFFFFFFFFFFFFFFFFFFFFE4E5E46D7270DBDBDAC2AB98C89D75D0A378CE
            9F72C59970C3AF9DDEDEDE6C716FE7E8E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            DDDEDE707371CACCCBDCDBDAD9D6D4D9D5D1DAD8D7C9CACA707371E0E1E1FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A6A47276756E72716B
            706E707573AFB1B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentFont = False
          ParentShowHint = False
          ParentBiDiMode = False
          ShowHint = True
          OnClick = SpeedButtonPesquisaCepClick
        end
        object Bevel1: TBevel
          Left = 8
          Top = 134
          Width = 582
          Height = 2
        end
        object Label6: TLabel
          Left = 27
          Top = 48
          Width = 49
          Height = 13
          Caption = 'Endere'#231'o:'
        end
        object Label7: TLabel
          Left = 7
          Top = 73
          Width = 69
          Height = 13
          Caption = 'Complemento:'
        end
        object Label8: TLabel
          Left = 347
          Top = 73
          Width = 32
          Height = 13
          Caption = 'Bairro:'
        end
        object Label9: TLabel
          Left = 39
          Top = 99
          Width = 37
          Height = 13
          Caption = 'Cidade:'
        end
        object Label10: TLabel
          Left = 342
          Top = 99
          Width = 37
          Height = 13
          Caption = 'Estado:'
        end
        object EditCep: TEdit
          Left = 81
          Top = 20
          Width = 105
          Height = 19
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnKeyPress = EditDataRegistroKeyPress
        end
        object EditEndereco: TEdit
          Left = 81
          Top = 47
          Width = 506
          Height = 19
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnKeyPress = EditDataRegistroKeyPress
        end
        object EditComplemento: TEdit
          Left = 81
          Top = 72
          Width = 197
          Height = 19
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnKeyPress = EditDataRegistroKeyPress
        end
        object EditBairro: TEdit
          Left = 390
          Top = 72
          Width = 197
          Height = 19
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnKeyPress = EditDataRegistroKeyPress
        end
        object EditCidade: TEdit
          Left = 81
          Top = 98
          Width = 197
          Height = 19
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnKeyPress = EditDataRegistroKeyPress
        end
        object EditEstado: TEdit
          Left = 390
          Top = 98
          Width = 197
          Height = 19
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnKeyPress = EditDataRegistroKeyPress
        end
      end
    end
  end
  object DBGrid1: TDBGrid [2]
    Left = 25
    Top = 254
    Width = 582
    Height = 119
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  inherited DataSourcePadrao: TDataSource
    DataSet = DataModuleCadastros.TbClientes
    Left = 608
    Top = 192
  end
end

inherited FormManutencaoEnderecos: TFormManutencaoEnderecos
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Endere'#231'os'
  ClientHeight = 338
  ClientWidth = 683
  Position = poOwnerFormCenter
  OnShow = FormShow
  ExplicitWidth = 689
  ExplicitHeight = 367
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBotoes: TPanel
    Left = 546
    Height = 338
    ExplicitLeft = 546
    ExplicitHeight = 338
    inherited SpeedButtonGravar: TSpeedButton
      Top = 11
      OnClick = SpeedButtonGravarClick
      ExplicitTop = 11
    end
    inherited SpeedButtonFechar: TSpeedButton
      Top = 292
      ExplicitTop = 300
    end
    inherited SpeedButtonCancelar: TSpeedButton
      Top = 56
      ExplicitTop = 56
    end
  end
  inherited PanelDados: TPanel
    Width = 546
    Height = 338
    ExplicitWidth = 546
    ExplicitHeight = 338
    object GroupBoxEnderecos: TGroupBox
      Left = 1
      Top = 1
      Width = 544
      Height = 336
      Align = alClient
      Caption = ' Dados do Endere'#231'o '
      TabOrder = 0
      object LabelCliente: TLabel
        Left = 16
        Top = 37
        Width = 46
        Height = 14
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 52
        Top = 81
        Width = 23
        Height = 13
        Caption = 'CEP:'
      end
      object Label5: TLabel
        Left = 16
        Top = 124
        Width = 59
        Height = 13
        Caption = 'Logradouro:'
      end
      object Label9: TLabel
        Left = 6
        Top = 165
        Width = 69
        Height = 13
        Caption = 'Complemento:'
      end
      object Label12: TLabel
        Left = 38
        Top = 281
        Width = 37
        Height = 13
        Caption = 'Estado:'
      end
      object Label10: TLabel
        Left = 38
        Top = 239
        Width = 37
        Height = 13
        Caption = 'Cidade:'
      end
      object SpeedButtonBuscaCep: TSpeedButton
        Left = 215
        Top = 75
        Width = 23
        Height = 23
        Hint = 'Pesquisa CEP via WebService'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFCCCCCCCCCCCCF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCC497FAA4980ACB1BDC6CFCFCFCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC407F
          AF1EAAFF5AC8FF4593C7BB8825B67E0EB57B09B67E0DB88113BB8211B6831B90
          7E5B7A7A7C7B79787B79788F816B72A1C558C8FFBAF2FF4193CCB67E0EFFFFFF
          FFFFFFFFFFFFB47800F0EEF481848DB6B9BEE4E8ECE2E5EAE4E6EAB8B7B7827A
          76CFE3ED3290D4FFFFFFB47B09FFFFFFFFFFFFFFFFFFC99A3B928267B9BBBFE8
          DDCEEEC57DF6D789FCE49AECE7D8BBBABC9B9084FFFFFFFFFFFFB47A07FFFFFF
          FFFFFFFFFFFFFFFFFF7B7A7CF0F3F8E7B572F0CF92F6DC94FFEFA4FBE499F0F2
          F8818288FFFFFFFFFFFFB47A08FFFFFFFFFFFFFFFFFFE1CAB07F7F81F5F9FEEB
          C696F5E1BEF3DAA0F6DB94F4D587F5F9FF868587FFFFFFFFFFFFB47B08FFFFFF
          D5BB9DDAC3A8B65A0084888CFEFFFFE3B076FAF2E4F4E1BDEFCE91ECC37CFEFF
          FF8A898BFFFFFFFFFFFFB47B08FFFFFFFFFFF7FFFFFFB65E06A9A39BCED2D5F6
          E3CFE2B074E9C494E5B571F8EBD7CFD1D79C8A67FFFFFFFFFFFFB47B09FFFFFF
          D6B892DBC1A1B5600ACBA2748F9093D3D7DCFFFFFFFFFFFFFFFFFFD1D3D79293
          9CB7821AFFFFFFFFFFFFB47B08FFFFFFFFFBE4FFFFF2B5600BE2B580D7AC7A9F
          8A7491959B9194988F9195B5B1ABFFFFFFB87E09FFFFFFFFFFFFB57B08FFFFFF
          DDB382E1BB8EB95D04BD6108BE6106BD6106C06003C06001BB5B00E2BA8BFFFF
          FFB67C09FFFFFFFFFFFFB57C09FFFFFF44C4FF46C8FFE5BB8649CEFF4ACFFFE7
          BD894ACFFF4ACEFFE5BA8542C7FFFFFFFFB67C09FFFFFFFFFFFFB67E0EFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFB67E0EFFFFFFFFFFFFBD8C27B67E0EB67C09B67B08B57B08B67B08B67B08B5
          7B08B67B08B67B08B57B08B67C09B67E0EBD8C27FFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButtonBuscaCepClick
      end
      object Label1: TLabel
        Left = 38
        Top = 201
        Width = 32
        Height = 13
        Caption = 'Bairro:'
      end
      object EditCep: TEdit
        Left = 92
        Top = 77
        Width = 121
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 10
        ParentFont = False
        TabOrder = 2
        OnExit = EditCepExit
        OnKeyPress = EditCepKeyPress
      end
      object EditEndereco: TEdit
        Left = 92
        Top = 120
        Width = 418
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 80
        ParentFont = False
        TabOrder = 3
      end
      object EditComplemento: TEdit
        Left = 92
        Top = 161
        Width = 289
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 25
        ParentFont = False
        TabOrder = 4
      end
      object EditEstado: TEdit
        Left = 92
        Top = 277
        Width = 121
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 50
        ParentFont = False
        TabOrder = 7
      end
      object EditIdEndereco: TEdit
        Left = 450
        Top = 16
        Width = 31
        Height = 21
        TabOrder = 1
        Visible = False
      end
      object EditCidade: TEdit
        Left = 92
        Top = 236
        Width = 289
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 100
        ParentFont = False
        TabOrder = 6
      end
      object EditIdCliente: TEdit
        Left = 413
        Top = 16
        Width = 31
        Height = 21
        TabOrder = 0
        Visible = False
      end
      object EditBairro: TEdit
        Left = 92
        Top = 197
        Width = 121
        Height = 19
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 50
        ParentFont = False
        TabOrder = 5
      end
    end
  end
  inherited DataSourcePadrao: TDataSource
    DataSet = DataModuleCadastros.TbEnderecos
    Left = 600
    Top = 144
  end
end

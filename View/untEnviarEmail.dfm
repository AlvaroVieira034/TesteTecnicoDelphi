object FormEnviarEmail: TFormEnviarEmail
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Envio de Email'
  ClientHeight = 383
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 12
    Top = 12
    Width = 22
    Height = 13
    Caption = 'Para'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 12
    Top = 58
    Width = 39
    Height = 13
    Caption = 'Assunto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 12
    Top = 104
    Width = 51
    Height = 13
    Caption = 'Mensagem'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 12
    Top = 283
    Width = 31
    Height = 13
    Caption = 'Anexo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EditPara: TEdit
    Left = 12
    Top = 31
    Width = 461
    Height = 21
    TabOrder = 0
  end
  object EditAssunto: TEdit
    Left = 12
    Top = 73
    Width = 461
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object memCorpo: TMemo
    Left = 12
    Top = 121
    Width = 461
    Height = 153
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object EditAnexo: TEdit
    Left = 12
    Top = 298
    Width = 461
    Height = 21
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 330
    Width = 488
    Height = 53
    Align = alBottom
    TabOrder = 4
    object SpeedButtonEnviar: TSpeedButton
      Left = 12
      Top = 11
      Width = 110
      Height = 31
      Caption = 'Enviar Email'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF148732037B1EFBFD
        FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF158D3C43A15F33954CF9FCFAFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF2398521D924A179044118C3D3A9F5E80C19646A3
        622E9447F8FBF9FFFFFFAA7D60B56D3EBC733CBF793FC27D43C38045299B5B90
        CAA98DC8A58AC6A188C59E6AB68582C29748A5661D7F29A47D5EAF724CF8F3EE
        F5ECE4FBF5F0FBF7F1FBF7F3319F6394CDAD6FBA8E6BB88966B68561B38067B5
        8283C2983CA05C048027BE703DFCF9F5ECD0BCF9E4D6FEECDFFEEBDF37A36B96
        CEB094CDAD91CBAA90CBA874BC908AC7A146A5680B8938C68B51C27646FDFBF8
        F9E3D2ECCFB9F8E1D0FDE7D63DA56F3AA36E36A168329E6255AF7C91CBAA4FAB
        741B9047F7F2EBC98C50C57D50FDFBF9FDE9D8F9E1D0EBCAB3ECC5A7E3B698F7
        E7DDF7E8DEE3B69740A2685AB381289857FCDFC6F8F3EDC88D50C9865BFDFBF9
        FDE8D7FDE6D4EDC6ABDCAA89F9ECE3FFFBF9FFFCFAF9EEE644A36D319F65FCDB
        C0FCDBC0F8F3EDC88C50CC8E66FDFBF9FDE5D3F1CCB2E3B596F9EAE0FFF9F5FE
        F3EAFEF4EDFFFBF9F9EDE5E3B08DF0C19EFCD7B7F8F3EDC88C50D09670FDFBF9
        F1CDB1E3B596F9E9DEFEF7F1FDEDE1FEEFE4FEF1E7FEF3EAFFFAF7F9ECE3E2AE
        8AF0BC95F8F4ECC88C50D39D7CFBF6F2E3B496F9E8DCFEF5EEFDE9DAFDEADCFD
        ECDEFDEDE1FEEFE4FEF1E7FFFAF6F9EAE0E2AA85F1E4D9C88C51DCB7A0FDFAF8
        FCF5F1FFFCF9FFFCF9FFFCF9FFFCF9FFFCFAFFFCFAFFFCFAFFFCFBFFFDFBFFFD
        FCFBF6F3F8EFEAB78A5ED6B39DD7A98BD19972CC9065CC8F63CB8F61CA8D5EC9
        8C5CC88B59C78957C68754C58551C5834FC38753BA885CAA7D60FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButtonEnviarClick
    end
    object SpeedButtonAnexar: TSpeedButton
      Left = 186
      Top = 11
      Width = 110
      Height = 31
      Caption = 'Anexar Arquivo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2F2D2D2D575757FDFDFDFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF36
        3636FFFFFFF1F1F1B1B1B15D5D5DF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6666666C6C6C5555551C1C1CA7A7A76060
        60FBFBFBFFFFFFFFFFFFAA7D60B56D3EBC733CBF793FC27D43C38045C38248A4
        805E5E5E5E5F4933C4894E3E362D8A7A69616161B08156AA7D60AF724CF8F3EE
        F5ECE4FBF5F0FBF7F1FBF7F3FBF8F4FCF9F5CCCAC86F6F6FA8A7A7FCFAF74C4C
        4B979594606060AA8158BE703DFCF9F5ECD0BCF9E4D6FEECDFFEEBDFFEEBDEFE
        EBDBFEEBDCD5C8BF707070ACA49FF8E0CD554B449C98934F4D4AC27646FDFBF8
        F9E3D2ECCFB9F8E1D0FDE7D6F4D5BDE9BFA0E9BFA2F4D3BDD7C6BA7373739590
        8CF8DBC4F8F2EC6A6662C57D50FDFBF9FDE9D8F9E1D0EBCAB3ECC5A7E3B698F7
        E7DDF7E8DEE3B697ECC3A4C8AF9B5B5B5B676767636363A77E54C9865BFDFBF9
        FDE8D7FDE6D4EDC6ABDCAA89F9ECE3FFFBF9FFFCFAF9EEE6DCA887EDBF9CFCDB
        C0FCDBC0F8F3EDC88C50CC8E66FDFBF9FDE5D3F1CCB2E3B596F9EAE0FFF9F5FE
        F3EAFEF4EDFFFBF9F9EDE5E3B08DF0C19EFCD7B7F8F3EDC88C50D09670FDFBF9
        F1CDB1E3B596F9E9DEFEF7F1FDEDE1FEEFE4FEF1E7FEF3EAFFFAF7F9ECE3E2AE
        8AF0BC95F8F4ECC88C50D39D7CFBF6F2E3B496F9E8DCFEF5EEFDE9DAFDEADCFD
        ECDEFDEDE1FEEFE4FEF1E7FFFAF6F9EAE0E2AA85F1E4D9C88C51DCB7A0FDFAF8
        FCF5F1FFFCF9FFFCF9FFFCF9FFFCF9FFFCFAFFFCFAFFFCFAFFFCFBFFFDFBFFFD
        FCFBF6F3F8EFEAB78A5ED6B39DD7A98BD19972CC9065CC8F63CB8F61CA8D5EC9
        8C5CC88B59C78957C68754C58551C5834FC38753BA885CAA7D60FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButtonAnexarClick
    end
    object SpeedButtonVoltar: TSpeedButton
      Left = 363
      Top = 11
      Width = 110
      Height = 31
      Caption = 'Voltar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7EDE889DF8E74D67AA3D1A6E7EDE8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFBFE0C14BD8533AD34381D686EDF1EDFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8EFE857DA5F37D4
        404ED656E0EAE1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFE0EBE03ED64737D4405ED765FEFEFEFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7ADA
        8037D44037D340C4DCC5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEF1EEA6DFA9FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF88D28C38D44137D44097D09AFFFFFFFFFFFF
        FFFFFFFFFFFFE6ECE65ED96588DD8EFFFFFFFFFFFFFFFFFFFFFFFFFBFCFB57D9
        5F39D54239D44294D197FFFFFFFFFFFFFFFFFFDEE8DF57D96040D84AB3D8B5FF
        FFFFFFFFFFFFFFFFF9FAF983D5883BD6453BD6443AD543B2D7B5FFFFFFFFFFFF
        D5E5D653DA5B42D94C42D94BDDEBDEE9EDE9CBDCCC9CD29F57D85F3ED7473DD7
        463CD64647D850F1F5F2FFFFFFCBE1CC50DA5845DA4E44DA4D43DA4D42D74C42
        D74B41D84B41D84A40D8493FD8493FD7483FD748B2E1B5FFFFFFCDE0CE4DDB57
        47DB5146DB5045DB4F45DA4E44DA4E43DA4D43D94C42D94C41D94B41D84A4ADA
        53B6E1B9FFFFFFFFFFFFA9D6AC49DC5348DC5248DC5147DB5146DB5046DB4F45
        DA4F44DA4E44DA4D50DC5993DF98EAF0EAFFFFFFFFFFFFFFFFFFFEFEFEB1DFB4
        56DF5F49DD5349DC5248DC5255DE5F77E47E96DB9BC5DEC6F9FBFAFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBF1EB87E28D4BDD5549DD5387E28CFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC7E2C964E26C4DDD57E3ECE4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F8F79CE0A1A6
        DCAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButtonVoltarClick
    end
  end
end

object frmeSocial: TfrmeSocial
  Left = 686
  Top = 231
  Caption = 'frmeSocial'
  ClientHeight = 623
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 376
    Top = 0
    Width = 49
    Height = 13
    Caption = 'Ambiente:'
  end
  object Label2: TLabel
    Left = 376
    Top = 40
    Width = 74
    Height = 13
    Caption = 'Vers'#227'o Manual:'
  end
  object Label3: TLabel
    Left = 8
    Top = 83
    Width = 56
    Height = 13
    Caption = 'Certificado:'
  end
  object lbl1: TLabel
    Left = 376
    Top = 272
    Width = 33
    Height = 13
    Caption = 'Grupo:'
  end
  object edtCnpjSH: TLabeledEdit
    Left = 8
    Top = 16
    Width = 162
    Height = 21
    EditLabel.Width = 140
    EditLabel.Height = 13
    EditLabel.Caption = 'CPF / CNPJ SoftWare House:'
    TabOrder = 0
  end
  object edtTokenSH: TLabeledEdit
    Left = 176
    Top = 16
    Width = 194
    Height = 21
    EditLabel.Width = 115
    EditLabel.Height = 13
    EditLabel.Caption = 'Token SoftWare House:'
    TabOrder = 1
  end
  object cbAmbiente: TComboBox
    Left = 376
    Top = 16
    Width = 145
    Height = 21
    TabOrder = 2
    Text = '2 - Homologa'#231#227'o'
    Items.Strings = (
      '1 - Produ'#231#227'o'
      '2 - Homologa'#231#227'o')
  end
  object cbVersaoManual: TComboBox
    Left = 376
    Top = 56
    Width = 145
    Height = 21
    TabOrder = 3
  end
  object edtCnpjTransmissor: TLabeledEdit
    Left = 8
    Top = 56
    Width = 162
    Height = 21
    EditLabel.Width = 89
    EditLabel.Height = 13
    EditLabel.Caption = 'CNPJ Transmissor:'
    TabOrder = 4
  end
  object edtCnpjEmpregador: TLabeledEdit
    Left = 176
    Top = 56
    Width = 194
    Height = 21
    EditLabel.Width = 90
    EditLabel.Height = 13
    EditLabel.Caption = 'CNPJ Empregador:'
    TabOrder = 5
  end
  object cbCertificado: TComboBox
    Left = 8
    Top = 96
    Width = 513
    Height = 21
    TabOrder = 6
  end
  object edtTemplates: TLabeledEdit
    Left = 8
    Top = 136
    Width = 513
    Height = 21
    EditLabel.Width = 97
    EditLabel.Height = 13
    EditLabel.Caption = 'Caminho Templates:'
    TabOrder = 7
    Text = 'C:\Program Files\TecnoSpeed\eSocial\Arquivos\Templates\'
  end
  object edtEsquemas: TLabeledEdit
    Left = 8
    Top = 176
    Width = 513
    Height = 21
    EditLabel.Width = 96
    EditLabel.Height = 13
    EditLabel.Caption = 'Caminho Esquemas:'
    TabOrder = 8
    Text = 'C:\Program Files\TecnoSpeed\eSocial\Arquivos\Esquemas\'
  end
  object btnConfigurar: TButton
    Left = 8
    Top = 210
    Width = 513
    Height = 25
    Caption = 'Configurar Componente'
    TabOrder = 9
    OnClick = btnConfigurarClick
  end
  object btnTx2: TButton
    Left = 8
    Top = 248
    Width = 90
    Height = 25
    Caption = 'Carregar Tx2'
    TabOrder = 10
    OnClick = btnTx2Click
  end
  object btnXML: TButton
    Left = 110
    Top = 248
    Width = 90
    Height = 25
    Caption = 'Gerar XML'
    TabOrder = 11
    OnClick = btnXMLClick
  end
  object btnAssinar: TButton
    Left = 215
    Top = 248
    Width = 90
    Height = 25
    Caption = 'Assinar'
    TabOrder = 12
    OnClick = btnAssinarClick
  end
  object btnEnviar: TButton
    Left = 322
    Top = 248
    Width = 90
    Height = 25
    Caption = 'Enviar'
    TabOrder = 13
    OnClick = btnEnviarClick
  end
  object btnConsultar: TButton
    Left = 431
    Top = 248
    Width = 90
    Height = 25
    Caption = 'Consultar'
    TabOrder = 14
    OnClick = btnConsultarClick
  end
  object edtIdLote: TLabeledEdit
    Left = 8
    Top = 288
    Width = 362
    Height = 21
    EditLabel.Width = 104
    EditLabel.Height = 13
    EditLabel.Caption = 'Identificador do Lote:'
    TabOrder = 15
  end
  object cbGrupo: TComboBox
    Left = 376
    Top = 288
    Width = 145
    Height = 21
    TabOrder = 16
    Text = '1'
    Items.Strings = (
      '1'
      '2'
      '3')
  end
  object mmoXML: TMemo
    Left = 8
    Top = 320
    Width = 513
    Height = 295
    ScrollBars = ssVertical
    TabOrder = 17
  end
end

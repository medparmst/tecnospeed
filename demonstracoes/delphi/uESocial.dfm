object frmESocial: TfrmESocial
  Left = 603
  Top = 146
  AutoSize = True
  Caption = 'frmESocial'
  ClientHeight = 690
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pcPages: TPageControl
    Left = 0
    Top = 272
    Width = 537
    Height = 418
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet4: TTabSheet
      Caption = 'TX2'
      ImageIndex = 3
      object mmTX2: TMemo
        Left = 8
        Top = 6
        Width = 513
        Height = 379
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Xml de Envio'
      ImageIndex = 1
      object mmoXmlEnvio: TMemo
        Left = 8
        Top = 6
        Width = 513
        Height = 379
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'XML Assinado'
      ImageIndex = 4
      object mmXMLAssinado: TMemo
        Left = 8
        Top = 6
        Width = 513
        Height = 379
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Retorno'
      object mmoXML: TMemo
        Left = 8
        Top = 6
        Width = 513
        Height = 379
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Enviado'
      ImageIndex = 5
      object mmEnviado: TMemo
        Left = 8
        Top = 6
        Width = 513
        Height = 379
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object Retornado: TTabSheet
      Caption = 'Retornado'
      ImageIndex = 6
      object mmRetornado: TMemo
        Left = 8
        Top = 6
        Width = 513
        Height = 379
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 538
    Height = 273
    ActivePage = TabSheet7
    TabOrder = 1
    object TabSheet3: TTabSheet
      Caption = '1 - Dados'
      object Label2: TLabel
        Left = 396
        Top = 44
        Width = 74
        Height = 13
        Caption = 'Vers'#227'o Manual:'
      end
      object Label1: TLabel
        Left = 396
        Top = 4
        Width = 47
        Height = 13
        Caption = 'Ambiente:'
      end
      object Label3: TLabel
        Left = 1
        Top = 83
        Width = 53
        Height = 13
        Caption = 'Certificado:'
      end
      object edtCnpjSH: TLabeledEdit
        Left = 1
        Top = 20
        Width = 192
        Height = 21
        EditLabel.Width = 143
        EditLabel.Height = 13
        EditLabel.Caption = 'CPF / CNPJ SoftWare House:'
        TabOrder = 0
        Text = '08187168000160'
      end
      object edtTokenSH: TLabeledEdit
        Left = 196
        Top = 20
        Width = 197
        Height = 21
        EditLabel.Width = 116
        EditLabel.Height = 13
        EditLabel.Caption = 'Token SoftWare House:'
        TabOrder = 1
      end
      object cbAmbiente: TComboBox
        Left = 397
        Top = 20
        Width = 132
        Height = 21
        ItemIndex = 1
        TabOrder = 2
        Text = '2 - Homologa'#231#227'o'
        Items.Strings = (
          '1 - Produ'#231#227'o'
          '2 - Homologa'#231#227'o')
      end
      object cbVersaoManual: TComboBox
        Left = 397
        Top = 60
        Width = 132
        Height = 21
        TabOrder = 3
      end
      object edtCnpjTransmissor: TLabeledEdit
        Left = 1
        Top = 60
        Width = 192
        Height = 21
        EditLabel.Width = 89
        EditLabel.Height = 13
        EditLabel.Caption = 'CNPJ Transmissor:'
        TabOrder = 4
        Text = '08187168000160'
      end
      object edtCnpjEmpregador: TLabeledEdit
        Left = 196
        Top = 60
        Width = 197
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'CNPJ Empregador:'
        TabOrder = 5
        Text = '08187168000160'
      end
      object cbCertificado: TComboBox
        Left = 1
        Top = 100
        Width = 528
        Height = 21
        TabOrder = 6
      end
      object edtTemplates: TLabeledEdit
        Left = 0
        Top = 140
        Width = 528
        Height = 21
        EditLabel.Width = 96
        EditLabel.Height = 13
        EditLabel.Caption = 'Caminho Templates:'
        TabOrder = 7
        Text = 'C:\Program Files\TecnoSpeed\eSocial\Arquivos\Templates\'
      end
      object edtEsquemas: TLabeledEdit
        Left = 1
        Top = 180
        Width = 528
        Height = 21
        EditLabel.Width = 96
        EditLabel.Height = 13
        EditLabel.Caption = 'Caminho Esquemas:'
        TabOrder = 8
        Text = 'C:\Program Files\TecnoSpeed\eSocial\Arquivos\Esquemas\'
      end
      object btnConfigurar: TButton
        Left = 60
        Top = 209
        Width = 169
        Height = 25
        Caption = 'Configurar Componente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        OnClick = btnConfigurarClick
      end
    end
    object TabSheet7: TTabSheet
      Caption = '2 - Envio'
      ImageIndex = 1
      object lbl1: TLabel
        Left = 415
        Top = 202
        Width = 32
        Height = 13
        Caption = 'Grupo:'
      end
      object btnTx2: TButton
        Left = 0
        Top = 87
        Width = 127
        Height = 25
        Caption = 'Carregar Tx2'
        TabOrder = 0
        OnClick = btnTx2Click
      end
      object btnXML: TButton
        Left = 133
        Top = 87
        Width = 127
        Height = 25
        Caption = 'Gerar XML'
        TabOrder = 1
        OnClick = btnXMLClick
      end
      object btnAssinar: TButton
        Left = 266
        Top = 87
        Width = 127
        Height = 25
        Caption = 'Assinar'
        TabOrder = 2
        OnClick = btnAssinarClick
      end
      object btnEnviar: TButton
        Left = 399
        Top = 87
        Width = 127
        Height = 25
        Caption = 'Enviar'
        TabOrder = 3
        OnClick = btnEnviarClick
      end
      object btnConsultar: TButton
        Left = 0
        Top = 168
        Width = 127
        Height = 25
        Caption = 'Consultar'
        TabOrder = 4
        OnClick = btnConsultarClick
      end
      object edtIdLote: TLabeledEdit
        Left = 1
        Top = 218
        Width = 412
        Height = 21
        EditLabel.Width = 100
        EditLabel.Height = 13
        EditLabel.Caption = 'Identificador do Lote:'
        TabOrder = 5
      end
      object cbGrupo: TComboBox
        Left = 415
        Top = 218
        Width = 112
        Height = 21
        TabOrder = 6
        Text = '1'
        Items.Strings = (
          '1'
          '2'
          '3')
      end
      object rgTipoEnvio: TRadioGroup
        Left = 0
        Top = 117
        Width = 527
        Height = 48
        Caption = 'Tipo de Consulta:'
        Columns = 3
        Items.Strings = (
          'Id de Lote'
          'Id de Evento'
          'Nr. Recibo')
        TabOrder = 7
      end
      object rgTipoTX2: TRadioGroup
        Left = 0
        Top = 2
        Width = 527
        Height = 82
        Caption = 'Tipo TX2:'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'S1000'
          'S1005'
          'S1010'
          'S1020'
          'S1030'
          'S1035'
          'S1040'
          'S1050'
          'S1060'
          'S1070'
          'S1080'
          'Carregar Arquivo')
        TabOrder = 8
      end
      object Button1: TButton
        Left = 133
        Top = 168
        Width = 127
        Height = 25
        Caption = 'For'#231'ar Consulta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = Button1Click
      end
    end
  end
  object openDlg: TOpenDialog
    Left = 1464
  end
end

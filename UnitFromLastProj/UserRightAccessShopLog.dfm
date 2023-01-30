object fUserRightAccessShopLog: TfUserRightAccessShopLog
  Left = 0
  Top = 0
  Caption = #1056#1077#1077#1089#1090#1088' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1087#1088#1072#1074
  ClientHeight = 651
  ClientWidth = 917
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid3: TcxGrid
    Left = 106
    Top = 0
    Width = 106
    Height = 651
    Align = alLeft
    TabOrder = 0
    object cxGrid3DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsUserRightAccessShopLog
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CellHints = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid3DBTableView1Column1: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'URASL_EventTime'
        HeaderAlignmentHorz = taCenter
      end
    end
    object cxGrid3Level1: TcxGridLevel
      GridView = cxGrid3DBTableView1
    end
  end
  object Panel3: TPanel
    Left = 212
    Top = 0
    Width = 705
    Height = 651
    Align = alClient
    TabOrder = 1
    object Panel8: TPanel
      Left = 1
      Top = 580
      Width = 703
      Height = 70
      Align = alBottom
      TabOrder = 0
      object DBEdit10: TDBEdit
        Left = 513
        Top = 46
        Width = 139
        Height = 21
        TabStop = False
        DataField = 'URASL_EventTime'
        DataSource = dsUserRightAccessShopLog
        ReadOnly = True
        TabOrder = 0
      end
      object cxDBLabel1: TcxDBLabel
        Left = 35
        Top = 45
        DataBinding.DataField = 'URASL_Event'
        DataBinding.DataSource = dsUserRightAccessShopLog
        Height = 21
        Width = 54
      end
      object DBEdit3: TDBEdit
        Left = 48
        Top = 0
        Width = 84
        Height = 21
        TabStop = False
        DataField = 'URASL_Code_Old'
        DataSource = dsUserRightAccessShopLog
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 1
        Top = 22
        Width = 324
        Height = 21
        TabStop = False
        DataField = 'URASL_Name_Old'
        DataSource = dsUserRightAccessShopLog
        ReadOnly = True
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 377
        Top = 0
        Width = 84
        Height = 21
        TabStop = False
        DataField = 'URASL_Code_New'
        DataSource = dsUserRightAccessShopLog
        ReadOnly = True
        TabOrder = 4
      end
      object DBEdit6: TDBEdit
        Left = 331
        Top = 23
        Width = 324
        Height = 21
        TabStop = False
        DataField = 'URASL_Name_New'
        DataSource = dsUserRightAccessShopLog
        ReadOnly = True
        TabOrder = 5
      end
      object cxLabel1: TcxLabel
        Left = 1
        Top = 1
        Caption = #1041#1099#1083#1086
      end
      object cxLabel2: TcxLabel
        Left = 329
        Top = 0
        Caption = #1057#1090#1072#1083#1086
      end
      object cxLabel4: TcxLabel
        Left = 84
        Top = 46
        Caption = 'HOSTNAME'
      end
      object cxLabel5: TcxLabel
        Left = 325
        Top = 46
        Caption = 'LoginName'
      end
      object cxDBMemo1: TcxDBMemo
        Left = 148
        Top = 46
        DataBinding.DataField = 'URASL_HOSTNAME'
        DataBinding.DataSource = dsUserRightAccessShopLog
        TabOrder = 10
        Height = 17
        Width = 177
      end
      object cxDBMemo2: TcxDBMemo
        Left = 383
        Top = 46
        DataBinding.DataField = 'URASL_LoginName'
        DataBinding.DataSource = dsUserRightAccessShopLog
        TabOrder = 11
        Height = 17
        Width = 126
      end
      object cxLabel3: TcxLabel
        Left = 0
        Top = 45
        Caption = 'Event:'
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 1
      Top = 575
      Width = 703
      Height = 5
      AlignSplitter = salBottom
      AutoSnap = True
      Control = Panel8
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 703
      Height = 574
      ActivePage = TSSMBig
      Align = alClient
      Images = ImageList1
      TabOrder = 2
      object TSSMBig: TTabSheet
        Tag = -1
        Caption = #1057#1091#1087#1077#1088' '#1073#1086#1083#1100#1096#1086#1081
        ImageIndex = 1
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 695
          Height = 545
          Align = alClient
          TabOrder = 0
          object Splitter3: TSplitter
            Left = 321
            Top = 1
            Width = 5
            Height = 543
            ExplicitHeight = 197
          end
          object fsSyntaxMemo2: TSyntaxMemo
            Left = 326
            Top = 1
            Width = 368
            Height = 543
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 0
            Lines.Strings = (
              'select * from Client where Cl_Id > 10000')
            ReadOnly = True
            MemoAttrs = <
              item
                KeywordsList = klOperators
                MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Keywords = '@login,@person,@r'
                KeywordsList = klProcAndFunct
                MemoFontItem = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1092#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            MemoStyles = <
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' /* */'
                EndChars = '*/'
                StartChars = '/*'
              end
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' --'
                StartChars = '--'
                StyleType = stEndOfLine
              end
              item
                MemoFontItem = #1057#1090#1088#1086#1082#1080
                Name = #1057#1090#1088#1086#1082#1072
                EndChars = #39
                StartChars = #39
              end>
            MemoFonts = <
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1058#1077#1082#1089#1090
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clTeal
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = [fsItalic]
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1057#1090#1088#1086#1082#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clFuchsia
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            SyntaxStyle = ssMSSQL
            ExplicitLeft = 321
            ExplicitWidth = 272
            ExplicitHeight = 197
          end
          object fsSyntaxMemo1: TSyntaxMemo
            Left = 1
            Top = 1
            Width = 320
            Height = 543
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 1
            Lines.Strings = (
              'select * from Client where Cl_Id > 10000')
            ReadOnly = True
            MemoAttrs = <
              item
                KeywordsList = klOperators
                MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Keywords = '@login,@person,@r'
                KeywordsList = klProcAndFunct
                MemoFontItem = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1092#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            MemoStyles = <
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' /* */'
                EndChars = '*/'
                StartChars = '/*'
              end
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' --'
                StartChars = '--'
                StyleType = stEndOfLine
              end
              item
                MemoFontItem = #1057#1090#1088#1086#1082#1080
                Name = #1057#1090#1088#1086#1082#1072
                EndChars = #39
                StartChars = #39
              end>
            MemoFonts = <
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1058#1077#1082#1089#1090
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clTeal
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = [fsItalic]
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1057#1090#1088#1086#1082#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clFuchsia
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            SyntaxStyle = ssMSSQL
          end
        end
      end
      object TSSMSmall: TTabSheet
        Tag = -1
        Caption = #1057#1091#1087#1077#1088' '#1084#1072#1083#1099#1081
        ImageIndex = 1
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 695
          Height = 545
          Align = alClient
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 321
            Top = 1
            Width = 5
            Height = 543
            ExplicitHeight = 197
          end
          object fsSyntaxMemo4: TSyntaxMemo
            Left = 326
            Top = 1
            Width = 368
            Height = 543
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 0
            Lines.Strings = (
              'select * from Client where Cl_Id > 10000')
            ReadOnly = True
            MemoAttrs = <
              item
                KeywordsList = klOperators
                MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Keywords = '@login,@person,@r'
                KeywordsList = klProcAndFunct
                MemoFontItem = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1092#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            MemoStyles = <
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' /* */'
                EndChars = '*/'
                StartChars = '/*'
              end
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' --'
                StartChars = '--'
                StyleType = stEndOfLine
              end
              item
                MemoFontItem = #1057#1090#1088#1086#1082#1080
                Name = #1057#1090#1088#1086#1082#1072
                EndChars = #39
                StartChars = #39
              end>
            MemoFonts = <
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1058#1077#1082#1089#1090
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clTeal
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = [fsItalic]
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1057#1090#1088#1086#1082#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clFuchsia
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            SyntaxStyle = ssMSSQL
            ExplicitLeft = 321
            ExplicitWidth = 272
            ExplicitHeight = 197
          end
          object fsSyntaxMemo3: TSyntaxMemo
            Left = 1
            Top = 1
            Width = 320
            Height = 543
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 1
            Lines.Strings = (
              'select * from Client where Cl_Id > 10000')
            ReadOnly = True
            MemoAttrs = <
              item
                KeywordsList = klOperators
                MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Keywords = '@login,@person,@r'
                KeywordsList = klProcAndFunct
                MemoFontItem = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1092#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            MemoStyles = <
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' /* */'
                EndChars = '*/'
                StartChars = '/*'
              end
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' --'
                StartChars = '--'
                StyleType = stEndOfLine
              end
              item
                MemoFontItem = #1057#1090#1088#1086#1082#1080
                Name = #1057#1090#1088#1086#1082#1072
                EndChars = #39
                StartChars = #39
              end>
            MemoFonts = <
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1058#1077#1082#1089#1090
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clTeal
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = [fsItalic]
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1057#1090#1088#1086#1082#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clFuchsia
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            SyntaxStyle = ssMSSQL
          end
        end
      end
      object TSSA: TTabSheet
        Tag = -1
        Caption = #1052#1072#1075#1072#1079#1080#1085
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 695
          Height = 545
          Align = alClient
          TabOrder = 0
          object Splitter2: TSplitter
            Left = 321
            Top = 1
            Width = 5
            Height = 543
            ExplicitHeight = 197
          end
          object fsSyntaxMemo6: TSyntaxMemo
            Left = 326
            Top = 1
            Width = 368
            Height = 543
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 0
            Lines.Strings = (
              'select * from Client where Cl_Id > 10000')
            ReadOnly = True
            MemoAttrs = <
              item
                KeywordsList = klOperators
                MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Keywords = '@login,@person,@r'
                KeywordsList = klProcAndFunct
                MemoFontItem = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1092#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            MemoStyles = <
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' /* */'
                EndChars = '*/'
                StartChars = '/*'
              end
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' --'
                StartChars = '--'
                StyleType = stEndOfLine
              end
              item
                MemoFontItem = #1057#1090#1088#1086#1082#1080
                Name = #1057#1090#1088#1086#1082#1072
                EndChars = #39
                StartChars = #39
              end>
            MemoFonts = <
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1058#1077#1082#1089#1090
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clTeal
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = [fsItalic]
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1057#1090#1088#1086#1082#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clFuchsia
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            SyntaxStyle = ssMSSQL
            ExplicitLeft = 327
            ExplicitTop = 0
            ExplicitHeight = 544
          end
          object fsSyntaxMemo5: TSyntaxMemo
            Left = 1
            Top = 1
            Width = 320
            Height = 543
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 1
            Lines.Strings = (
              'select * from Client where Cl_Id > 10000')
            ReadOnly = True
            MemoAttrs = <
              item
                KeywordsList = klOperators
                MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Keywords = '@login,@person,@r'
                KeywordsList = klProcAndFunct
                MemoFontItem = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1092#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            MemoStyles = <
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' /* */'
                EndChars = '*/'
                StartChars = '/*'
              end
              item
                MemoFontItem = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' --'
                StartChars = '--'
                StyleType = stEndOfLine
              end
              item
                MemoFontItem = #1057#1090#1088#1086#1082#1080
                Name = #1057#1090#1088#1086#1082#1072
                EndChars = #39
                StartChars = #39
              end>
            MemoFonts = <
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1058#1077#1082#1089#1090
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clTeal
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = [fsItalic]
                Name = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1057#1090#1088#1086#1082#1080
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clFuchsia
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                Name = #1060#1091#1085#1082#1094#1080#1080' '#1080' '#1087#1088#1086#1089#1077#1076#1091#1088#1099
              end>
            SyntaxStyle = ssMSSQL
          end
        end
      end
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 106
    Height = 651
    Align = alLeft
    TabOrder = 2
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsUserRightAccessList
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = DataModule1.il16
      OptionsBehavior.CellHints = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGridDBColumnURA_Code: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'URA_Code'
        HeaderAlignmentHorz = taCenter
      end
      object cxGridDBColumnIsDel: TcxGridDBColumn
        Caption = '-'
        DataBinding.FieldName = 'IsDel'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = DataModule1.il16
        Properties.Items = <
          item
            Description = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
            Value = 0
          end
          item
            Description = #1041#1099#1083' '#1079#1072#1084#1077#1095#1077#1085' '#1074' '#1082#1086#1088#1079#1080#1085#1077
            ImageIndex = 9
            Value = 1
          end>
        Properties.ShowDescriptions = False
        HeaderAlignmentHorz = taCenter
        HeaderHint = #1063#1090#1086' '#1074' '#1082#1086#1088#1079#1080#1085#1077
        Width = 20
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView1
    end
  end
  object dsUserRightAccessShopLog: TDataSource
    AutoEdit = False
    DataSet = qryUserRightAccessShopLog
    OnDataChange = dsUserRightAccessShopLogDataChange
    Left = 353
    Top = 97
  end
  object qryUserRightAccessShopLog: TADOQuery
    Parameters = <
      item
        Name = 'Code'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM UserRightAccessShopLog UR'
      'WHERE :Code IN (URASL_Code_Old, URASL_Code_New)'
      'ORDER BY 1  DESC')
    Left = 353
    Top = 129
  end
  object qryUserRightAccessList: TADOQuery
    Connection = DataModule1.Connection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT DISTINCT URA_Code, IsNull (IsDel, 0) AS IsDel'
      'FROM (SELECT DISTINCT URASL_Code_Old AS URA_Code'
      '      FROM UserRightAccessShopLog'
      '      WHERE URASL_Code_Old IS NOT NULL'
      '      UNION'
      '      SELECT DISTINCT URASL_Code_New'
      '      FROM UserRightAccessShopLog'
      '      WHERE URASL_Code_New IS NOT NULL) t'
      '     OUTER APPLY (SELECT 1 AS IsDel'
      '                  FROM UserRightAccessShopLog'
      
        '                  WHERE URA_Code IN (URASL_Code_Old, URASL_Code_' +
        'New) AND URASL_Event = '#39'Delete'#39') d'
      'ORDER BY 1')
    Left = 216
    Top = 144
  end
  object dsUserRightAccessList: TDataSource
    DataSet = qryUserRightAccessList
    OnDataChange = dsUserRightAccessListDataChange
    Left = 216
    Top = 96
  end
  object ImageList1: TImageList
    Left = 417
    Top = 265
    Bitmap = {
      494C0101020008005C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EDED
      ED12A1A1A15E696C6E9A4B5155BA41494DC6454B4EBF565B5FAE8183847FCBCB
      CB34000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F00F32444DFD667C86FF97AB
      B4FFC8E0E7FFDAF2F9FFDEF6FCFFEAFDFFFFDEF6FCFFDEF7FDFFDBF2F9FFB7CA
      CFFF7D929CFF4D626EFF6F727395000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080800000000000000000000000
      000000000000000000000000000000000000BDD2DCFFB5D4DEFF58656AFF9A9F
      A1FF191712FF1B1A16FF2A2C2AFF787776FF23211DFF262623FF000000FF8AA9
      BBFF121516FFA4BCC2FFD0E4EAFF5A676BD60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      8000000000000080800000000000008080000000000000808000000000000080
      800000000000000000000000000000000000B4CBD6FF232829FF40443FFFA8AD
      AFFF3D403CFF40413DFF32332EFF83807FFF1C1B15FF30312DFF22201EFFC2E0
      EEFF000000FF000000FF5E7B8AFF8FA0A8CF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000808000000000000000000000808000008080000000
      000000000000000000000000000000000000E3E3E475303432FF282A28FF4353
      5BFF314C5BFF5A7B8DFF618396FF4B6E82FF628398FF698A9CFF3A596AFF374F
      5CFF1F282BFF020000FF8FABB5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C00000808000008080000080
      8000008080000080800000808000008080000080800000000000008000000080
      800000808000000000000000000000000000939FA3B18AAAB8FFC6DFE8FFC7DE
      E4FF9EB6BCFF96A3A5FF767F81FF717A7BFF7B8586FF858E91FF95A4A7FFB5D0
      D6FFDAF1F7FFB3CFDBFF607E8DFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000008080000080
      800000808000008080000080800000808000008080000080800000FFFF000000
      00000080800000FFFF00000000000000000098B5C2FF687275FF514B49FF5D5C
      58FF5E6467FF67737AFF4B5E67FF5E717CFF5E727DFF5A6B73FF687175FF6B6D
      6DFF555150FF4A4847FFA2BCC4FFAEC4CDDA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000008080000080
      800000808000008080000080800000FFFF0000FFFF00000000000080800000FF
      FF0000FFFF0000000000000000000000000084979EFF697D85FF7D9EAFFF94B0
      BEFFB9D2DDFFCFE6EDFFCFE4E9FFA9C6CEFFC8DDE3FFCBDFE6FFCCE4EAFFB2CD
      D8FF7D9EAFFF668798FF7B7C7BFFE4EBED5B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000008080000000000000000000B8C1C486BBD0D8FF8399A3FF595F
      5FFF5C5B59FF484643FF555453FF716F6DFF545250FF656462FF575654FF4344
      41FF565D5FFFB9D1D8FFC0D6DEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000000000000C0C0C00000FF
      FF0000000000000000000080800000FFFF0000FFFF0000808000000000000080
      800000808000000000000000000080000000D6DDE0727D96A2FF4F4F4FFF5267
      71FF638596FF62899CFF80A2B4FF789AADFF8AACBCFF7396A9FF658A9CFF587A
      8AFF6C7E87FF7E7A76FFA1C5D3FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000000000000C0C0C00000FF
      FF0000FFFF0000FFFF0000000000000000000000000000808000008080000080
      80000080800000000000000000008000000000000000C0C5C8A2B3CDD9FFBED4
      DCFF919D9FFF565A5AFF313333FF4D504FFF444746FF424443FF676E6EFF8E9D
      9FFFD4EAF1FFA1BEC8FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      000000FFFF0000FFFF0000808000008080000080800000FFFF0000FFFF0000FF
      FF000080800000000000800000008000000000000000F0F2F42B68797FFF4C4C
      4CFF3D3F3FFF484A4AFF616566FF6A6D6EFF616566FF555758FF4C4D50FF4548
      49FF3B3A3AFF86A0AAFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      000000000000008080000080800000FFFF000080800000000000000000000000
      0000000000008000000080000000800000000000000000000000636464E21213
      13FF111111FF454545FF4B4C4DFF616363FF4D4F4FFF494D4DFF414444FF3C40
      41FF272B2DFFDFE1E23900000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000000000000000000000F5F5F517686A
      6BFF464A4DFF2F3233FF262829FF323334FF2F3132FF303334FF232627FF393C
      3EFF434648FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000000000000000000000000000001E20
      21F5181918FF181818FF535657FF686B6CFF6D7171FF606465FF313436FF2325
      27FF9394949E0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000191E21FF2A2F31FF434749FF595D5EFF696C6EFF6E7172FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFE00F00000000FF7F000100000000
      E00F000000000000C00F00000000000000070001000000000003000100000000
      80030000000000008000000000000000C0020001000000004002000100000000
      400680030000000020048003000000000808C003000000007FF0C00700000000
      FFFCE00700000000FFFEF81F0000000000000000000000000000000000000000
      000000000000}
  end
end

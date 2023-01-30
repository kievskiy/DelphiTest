object fmUserRightAccessShopEdit: TfmUserRightAccessShopEdit
  Left = 0
  Top = 0
  Caption = #1044#1086#1089#1090#1091#1087' '#1085#1072' '#1058#1058
  ClientHeight = 527
  ClientWidth = 942
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 942
    Height = 527
    Align = alClient
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 404
      Width = 940
      Height = 122
      Align = alBottom
      TabOrder = 0
      object Splitter1: TSplitter
        Left = 116
        Top = 23
        Height = 98
        ExplicitLeft = 168
        ExplicitTop = 56
        ExplicitHeight = 100
      end
      object Panel2: TPanel
        Left = 1
        Top = 23
        Width = 115
        Height = 98
        Align = alLeft
        TabOrder = 0
        object btnHelp: TBitBtn
          Left = 5
          Top = 3
          Width = 105
          Height = 22
          Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1076#1085#1086#1075#1086
          TabOrder = 0
          OnClick = btnHelpClick
        end
        object FuckAllBtn: TBitBtn
          Left = 5
          Top = 28
          Width = 105
          Height = 22
          Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1074#1089#1077#1093
          TabOrder = 1
          OnClick = FuckAllBtnClick
        end
        object FuckAllBtnNoDis: TBitBtn
          Tag = 1
          Left = 5
          Top = 50
          Width = 105
          Height = 32
          Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1074#1089#1077#1093' ('#1073#1077#1079' '#1091#1074#1086#1083#1077#1085#1085#1099#1093')'
          TabOrder = 2
          WordWrap = True
          OnClick = FuckAllBtnClick
        end
      end
      object Panel5: TPanel
        Left = 119
        Top = 23
        Width = 820
        Height = 98
        Align = alClient
        Caption = 'Panel5'
        TabOrder = 1
        object cxGrid1: TcxGrid
          Left = 1
          Top = 1
          Width = 818
          Height = 96
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfStandard
          object cxGrid1DBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsUser1
            DataController.DetailKeyFieldNames = 'UR_ID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnHiding = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Visible = True
            object cxGrid1DBTableView1Column1: TcxGridDBColumn
              Caption = '?'
              DataBinding.FieldName = 'IsAccessStr'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Width = 30
            end
            object cxGrid1DBTableView1Ur_id: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'Ur_id'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Default = True
                  Kind = bkEllipsis
                end>
              Properties.ReadOnly = True
              HeaderAlignmentHorz = taCenter
              HeaderHint = #1050#1086#1076' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Ur_Id) - @Login'
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 35
            end
            object cxGrid1DBTableView1UR_Name: TcxGridDBColumn
              Caption = #1051#1086#1075#1080#1085
              DataBinding.FieldName = 'UR_Name'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 115
            end
            object cxGrid1DBTableView1Pe_Id: TcxGridDBColumn
              Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
              DataBinding.FieldName = 'Pe_Id'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taRightJustify
              HeaderAlignmentHorz = taCenter
              HeaderHint = #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1089#1086#1090#1088#1091#1076#1085#1080#1082' (Pe_Id) - @PersonLocal'
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 70
            end
            object cxGrid1DBTableView1Pe_IDBase: TcxGridDBColumn
              DataBinding.FieldName = 'Pe_IDBase'
              HeaderAlignmentHorz = taCenter
              HeaderHint = #1050#1086#1076' '#1085#1072' '#1073#1072#1079#1077' (Pe_idBase) - @Person'
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
            end
            object cxGrid1DBTableView1Pe_FullName: TcxGridDBColumn
              Caption = #1060'.'#1048'.'#1054'.'
              DataBinding.FieldName = 'Pe_FullName'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 300
            end
            object cxGrid1DBTableView1GR_Name: TcxGridDBColumn
              Caption = #1056#1086#1083#1080
              DataBinding.FieldName = 'GR_Name'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
            end
          end
          object cxGrid1DBTableView2: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsUser2
            DataController.DetailKeyFieldNames = 'UR_ID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnHiding = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Visible = True
            object cxGrid1DBTableView2Column1: TcxGridDBColumn
              Caption = '?'
              DataBinding.FieldName = 'IsAccessStr'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Width = 30
            end
            object cxGrid1DBTableView2Ur_id: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'Ur_id'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Default = True
                  Kind = bkEllipsis
                end>
              Properties.ReadOnly = True
              HeaderAlignmentHorz = taCenter
              HeaderHint = #1050#1086#1076' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Ur_Id) - @Login'
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 35
            end
            object cxGrid1DBTableView2UR_Name: TcxGridDBColumn
              Caption = #1051#1086#1075#1080#1085
              DataBinding.FieldName = 'UR_Name'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 115
            end
            object cxGrid1DBTableView2Pe_Id: TcxGridDBColumn
              Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
              DataBinding.FieldName = 'Pe_Id'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taRightJustify
              HeaderAlignmentHorz = taCenter
              HeaderHint = #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1089#1086#1090#1088#1091#1076#1085#1080#1082' (Pe_Id) - @PersonLocal'
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 70
            end
            object cxGrid1DBTableView2Pe_FullName: TcxGridDBColumn
              Caption = #1060'.'#1048'.'#1054'.'
              DataBinding.FieldName = 'Pe_FullName'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 300
            end
            object cxGrid1DBTableView2GR_Name: TcxGridDBColumn
              Caption = #1056#1086#1083#1080
              DataBinding.FieldName = 'GR_Name'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
            end
          end
          object cxGrid1DBTableView3: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsUser3
            DataController.DetailKeyFieldNames = 'UR_ID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnHiding = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Visible = True
            object cxGrid1DBTableView3Column1: TcxGridDBColumn
              Caption = '?'
              DataBinding.FieldName = 'IsAccessStr'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Width = 30
            end
            object cxGrid1DBTableView3Ur_id: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'Ur_id'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Default = True
                  Kind = bkEllipsis
                end>
              Properties.ReadOnly = True
              HeaderAlignmentHorz = taCenter
              HeaderHint = #1050#1086#1076' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Ur_Id) - @Login'
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 35
            end
            object cxGrid1DBTableView3UR_Name: TcxGridDBColumn
              Caption = #1051#1086#1075#1080#1085
              DataBinding.FieldName = 'UR_Name'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 115
            end
            object cxGrid1DBTableView3Pe_Id: TcxGridDBColumn
              Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
              DataBinding.FieldName = 'Pe_Id'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taRightJustify
              HeaderAlignmentHorz = taCenter
              HeaderHint = #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1089#1086#1090#1088#1091#1076#1085#1080#1082' (Pe_Id) - @PersonLocal'
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 70
            end
            object cxGrid1DBTableView3Pe_FullName: TcxGridDBColumn
              Caption = #1060'.'#1048'.'#1054'.'
              DataBinding.FieldName = 'Pe_FullName'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 300
            end
            object cxGrid1DBTableView3GR_Name: TcxGridDBColumn
              Caption = #1056#1086#1083#1080
              DataBinding.FieldName = 'GR_Name'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
      object pnl2: TPanel
        Left = 1
        Top = 1
        Width = 938
        Height = 22
        Align = alTop
        TabOrder = 2
        object lbUserAccessResult: TLabel
          Left = 20
          Top = 2
          Width = 9
          Height = 18
          Caption = '?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbPlName: TLabel
          Left = 273
          Top = 0
          Width = 82
          Height = 18
          Caption = #1058#1091#1090' '#1080#1084#1103' '#1058#1058
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object sbSetPlace: TSpeedButton
          Left = 244
          Top = 0
          Width = 23
          Height = 22
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1076#1088#1091#1075#1086#1077' '#1058#1058' '#1076#1072#1085#1085#1086#1075#1086' '#1090#1080#1087#1072
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000030000000B00000013000000190000001A0000
            00140000000B0000000300000000000000000000000000000000000000000000
            000000000000000000060402011C4827118B7C431ED2A65927FFA55927FF7E44
            1ED442230F7B0100000F0000000E000000070000000000000000000000000000
            000000000005120A05348A4F26DDC58A53FFDCB37CFFEFD298FFEFD198FFB676
            43FF2E1A0C62100904398F5127E10E05013A0000000600000000000000000000
            0002040201198D552BDCD1A169FFF1D6A5FFCE9E6EFFC08656FFBD8251FF613A
            1DA6000000227D4B26CBE2B97BFF5F290FCF0101001900000003000000000000
            00074C2F1B82C99765FFECD2A3FFB98154FB5238238A120C07300F0A06270201
            01194C2F1B88CE9D66FFF6DC9BFFBA8657FF3F1C0C910000000D000000000000
            000A8C5B36D0E3C598FFCB9D75FF573B258C0000000C00000003000000062014
            0C43BD875AFBF8E5BCFFF8DFA5FFF7E4BAFFA16540FC1C0E074C000000080000
            0014B37A4BFAF5E6BDFFBC8356FF0D0704300000000C00000003000000079666
            3FD5B87D4DFFBB8153FFF2D9A1FFB87D4DFFB87C4DFF9C6941DE845331D3A263
            3BFFBB8557FFF6E7BFFFBF8B5EFFA06238FF87522FDC00000006000000020000
            000B0D08042FA1653CFFF4DEAEFFB68155FA000000180000000A1F170F34C79D
            75FBFBF5DCFFFCF3CCFFFAF4DAFFB3855FFB21150C4100000004000000020000
            0009492C1886BA8B5EFFE7CEA7FF926B48CB0000000900000000000000045540
            2D77DDC1A2FFFDF7D9FFD4B598FF5037227F0202010C0D08041F110A05274B2D
            1986A1683EFAF3E4C3FFD8B692FF533F2C780000000400000000000000000000
            00058F6F50BCEFE1CDFF886343C20202010D58382091A3693CFFA66F43FFBE94
            6DFFF4E9D1FFE3CAADFFA47E5BD60504030E0000000100000000000000000000
            0001130F0B1DAB8863DA18130E242C1E1248B78B63FDF8F3E2FFF9F3E4FFEDDE
            C7FFDCC1A1FFA3815ED215110C22000000020000000000000000000000000000
            000000000001000000010101000342301E629A7B5CC2C6A078F9C6A078F9997B
            5DC3564634710504030A00000001000000000000000000000000000000000000
            0000000000000000000000000000000000010000000200000002000000020000
            0002000000010000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = sbSetPlaceClick
        end
        object SpeedButton3: TSpeedButton
          Left = 215
          Top = 0
          Width = 23
          Height = 22
          Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1085#1072' '#1086#1089#1090#1072#1083#1100#1085#1099#1077' '#1090#1080#1087#1099' '#1058#1058
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00000000000000
            0000FFFFFF00000000000000000000000000FFFFFF0000000000FF00FF00FF00
            FF00FF00FF0000000000FF00FF00FF00FF0000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00
            FF00FF00FF000000FF0000000000FF00FF0000000000FFFFFF0000000000C6C6
            C6000000000000000000FFFFFF0000000000FFFFFF0000000000FF00FF00FF00
            FF00FF00FF000000FF000000FF000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            FF000000FF000000FF000000FF000000FF0000000000FFFFFF00000000000000
            0000FFFFFF000000000000000000000000000000000000000000000000000000
            FF000000FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFF
            FF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FF00FF00000000000000
            FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000C6C6
            C600FFFFFF0000000000FFFFFF0000000000FF00FF00FF00FF00000000000000
            FF000000FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000FF00FF00FF00FF00FF00FF00000000000000
            FF000000FF000000FF000000FF000000FF000000000000000000000000000000
            00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF000000FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton3Click
        end
      end
    end
    object pnl1: TPanel
      Left = 1
      Top = 1
      Width = 940
      Height = 403
      Align = alClient
      TabOrder = 1
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 938
        Height = 66
        Align = alTop
        TabOrder = 0
        object lbl1: TLabel
          Left = 10
          Top = 4
          Width = 20
          Height = 13
          Caption = #1050#1086#1076
        end
        object lbl3: TLabel
          Left = 10
          Top = 23
          Width = 61
          Height = 13
          Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        end
        object Label1: TLabel
          Left = 10
          Top = 42
          Width = 70
          Height = 13
          Caption = #1058#1077#1082#1089#1090' '#1086#1096#1080#1073#1082#1080
        end
        object DBEdit1: TDBEdit
          Left = 86
          Top = 1
          Width = 60
          Height = 21
          DataField = 'URAS_Code'
          DataSource = dsUserRightAccess
          TabOrder = 0
        end
        object DBEdit2: TDBEdit
          Left = 86
          Top = 21
          Width = 629
          Height = 21
          DataField = 'URAS_Name'
          DataSource = dsUserRightAccess
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Panel12: TPanel
          Left = 887
          Top = 1
          Width = 50
          Height = 64
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          object SpeedButton1: TSpeedButton
            Left = 3
            Top = 14
            Width = 20
            Height = 20
            Caption = '+'
          end
          object SpeedButton2: TSpeedButton
            Left = 24
            Top = 14
            Width = 20
            Height = 20
            Caption = '-'
          end
        end
        object DBEdit7: TDBEdit
          Left = 86
          Top = 39
          Width = 629
          Height = 21
          DataField = 'URAS_MessError'
          DataSource = dsUserRightAccess
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
      object PageControl1: TPageControl
        Left = 1
        Top = 67
        Width = 938
        Height = 335
        ActivePage = TabSheet4
        Align = alClient
        Images = DataModule1.il16
        TabOrder = 1
        object TabSheet1: TTabSheet
          ImageIndex = 167
          object cxPageControl1: TcxPageControl
            Left = 0
            Top = 0
            Width = 930
            Height = 306
            Align = alClient
            TabOrder = 0
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 302
            ClientRectLeft = 4
            ClientRectRight = 926
            ClientRectTop = 4
          end
          object PageControl2: TPageControl
            Left = 0
            Top = 0
            Width = 930
            Height = 306
            ActivePage = TSSMBig
            Align = alClient
            Images = ImageList1
            TabOrder = 1
            OnChange = PageControl2Change
            object TSSMBig: TTabSheet
              Tag = -1
              Caption = #1057#1091#1087#1077#1088' '#1073#1086#1083#1100#1096#1086#1081
              ImageIndex = 1
              object smSMBig: TSyntaxMemo
                Left = 0
                Top = 0
                Width = 922
                Height = 277
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                TabOrder = 0
                Lines.Strings = (
                  'select * from Client where Cl_Id > 10000')
                ReadOnly = False
                MemoAttrs = <
                  item
                    KeywordsList = klOperators
                    MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                    Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                  end
                  item
                    Keywords = '@login,@person,@r,@personlocal,fnexistsgroup'
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
                OnChange = smSMBigChange
                ExplicitLeft = -3
                ExplicitTop = 3
              end
            end
            object TSSMSmall: TTabSheet
              Tag = -1
              Caption = #1057#1091#1087#1077#1088' '#1084#1072#1083#1099#1081
              ImageIndex = 1
              object smSMSmall: TSyntaxMemo
                Left = 0
                Top = 0
                Width = 922
                Height = 277
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                TabOrder = 0
                Lines.Strings = (
                  'select * from Client where Cl_Id > 10000')
                ReadOnly = False
                MemoAttrs = <
                  item
                    KeywordsList = klOperators
                    MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                    Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                  end
                  item
                    Keywords = '@login,@person,@r,@personlocal,fnexistsgroup'
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
                OnChange = smSMSmallChange
                ExplicitTop = 3
                ExplicitHeight = 297
              end
            end
            object TSSA: TTabSheet
              Tag = -1
              Caption = #1052#1072#1075#1072#1079#1080#1085
              object smSA: TSyntaxMemo
                Left = 0
                Top = 0
                Width = 922
                Height = 277
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                TabOrder = 0
                Lines.Strings = (
                  'select * from Client where Cl_Id > 10000')
                ReadOnly = False
                MemoAttrs = <
                  item
                    KeywordsList = klOperators
                    MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                    Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                  end
                  item
                    Keywords = '@login,@person,@r,@personlocal,fnexistsgroup'
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
                OnChange = smSAChange
                ExplicitTop = 3
              end
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = #1063#1090#1086' '#1085#1072' '#1084#1072#1075#1072#1079#1080#1085#1077
          ImageIndex = 26
          object Panel7: TPanel
            Left = 0
            Top = 265
            Width = 930
            Height = 41
            Align = alBottom
            TabOrder = 0
            object mm_CopyURASInCurrentShop: TBitBtn
              Left = 285
              Top = 6
              Width = 105
              Height = 22
              Hint = #1055#1088#1080#1085#1091#1076#1080#1090#1077#1083#1100#1085#1086' '#1082#1086#1087#1080#1088#1091#1077#1084' '#1085#1077' '#1089#1084#1086#1090#1088#1103' '#1085#1072' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1085#1072' '#1058#1058
              Caption = #1055#1085#1091#1090#1100' '#1085#1072' '#1084#1072#1075#1072#1079#1080#1085
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = mm_CopyURASInCurrentShopClick
            end
            object BitBtn1: TBitBtn
              Left = 421
              Top = 6
              Width = 124
              Height = 22
              Hint = #1055#1099#1090#1072#1077#1084#1089#1103' '#1074#1087#1080#1093#1085#1091#1090#1100' '#1075#1076#1077' '#1085#1077#1090' '#1089#1074#1077#1078#1072#1082#1072
              Caption = #1055#1085#1091#1090#1100' '#1085#1072' '#1074#1089#1077' '#1084#1072#1075#1072#1079#1080#1085#1099
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = BitBtn1Click
            end
          end
          object Panel10: TPanel
            Left = 0
            Top = 0
            Width = 930
            Height = 265
            Align = alClient
            TabOrder = 1
            object cxGrid2: TcxGrid
              Left = 1
              Top = 1
              Width = 823
              Height = 263
              Align = alClient
              TabOrder = 0
              LookAndFeel.Kind = lfStandard
              object cxGridDBTableView1: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                DataController.DataSource = dsUnloadLog
                DataController.DetailKeyFieldNames = 'UR_ID'
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.IncSearch = True
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.ColumnAutoWidth = True
                OptionsView.GroupByBox = False
                Preview.Visible = True
                object cxGridDBTableView1Column1: TcxGridDBColumn
                  Caption = #1050#1086#1076
                  DataBinding.FieldName = 'pl_Id'
                  HeaderAlignmentHorz = taCenter
                end
                object cxGridDBTableView1Column2: TcxGridDBColumn
                  Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
                  DataBinding.FieldName = 'Pl_Name'
                  HeaderAlignmentHorz = taCenter
                end
                object cxGridDBTableView1Column3: TcxGridDBColumn
                  Caption = #1059#1089#1087#1077#1093
                  DataBinding.FieldName = 'URAUL_Success'
                  PropertiesClassName = 'TcxImageComboBoxProperties'
                  Properties.Alignment.Horz = taCenter
                  Properties.Images = DataModule1.cxIL16
                  Properties.Items = <
                    item
                      ImageIndex = 2
                      Value = True
                    end>
                  HeaderAlignmentHorz = taCenter
                end
                object cxGridDBTableView1Column4: TcxGridDBColumn
                  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' ('#1058#1088#1077#1081#1076')'
                  DataBinding.FieldName = 'URAS_DateUpdate'
                  HeaderAlignmentHorz = taCenter
                end
                object cxGridDBTableView1Column5: TcxGridDBColumn
                  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' ('#1058#1058')'
                  DataBinding.FieldName = 'URAUL_URAS_DateUpdate'
                  HeaderAlignmentHorz = taCenter
                end
                object cxGridDBTableView1Column7: TcxGridDBColumn
                  Caption = #1050#1086#1075#1076#1072' '#1091#1096#1083#1086
                  DataBinding.FieldName = 'URAUL_UnloadTime'
                  HeaderAlignmentHorz = taCenter
                end
              end
              object cxGridLevel1: TcxGridLevel
                GridView = cxGridDBTableView1
              end
            end
            object cxSplitter2: TcxSplitter
              Left = 824
              Top = 1
              Width = 8
              Height = 263
              AlignSplitter = salRight
            end
            object Panel11: TPanel
              Left = 832
              Top = 1
              Width = 97
              Height = 263
              Align = alRight
              TabOrder = 2
              object cxDBMemo3: TcxDBMemo
                Left = 1
                Top = 25
                Align = alClient
                DataBinding.DataField = 'URAUL_ErrMsg'
                DataBinding.DataSource = dsUnloadLog
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -9
                Style.Font.Name = 'Tahoma'
                Style.Font.Style = []
                Style.IsFontAssigned = True
                TabOrder = 0
                Height = 237
                Width = 95
              end
              object Panel13: TPanel
                Left = 1
                Top = 1
                Width = 95
                Height = 24
                Align = alTop
                Caption = #1058#1077#1082#1089#1090' '#1086#1096#1080#1073#1082#1080
                TabOrder = 1
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #1055#1086#1084#1086#1097#1100
          ImageIndex = 43
          object SyntaxMemo2: TSyntaxMemo
            Left = 0
            Top = 0
            Width = 930
            Height = 306
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 0
            Lines.Strings = (
              
                '@R - '#1074#1086#1079#1088#1072#1097#1072#1077#1084#1099#1081' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' (bit) '#1076#1086#1083#1078#1077#1085' '#1073#1099#1090#1100' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086' '#1079#1072#1087#1086#1083#1085#1077 +
                #1085
              '@Login - '#1082#1086#1076' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Ur_Id)'
              
                '@Person - '#1076#1083#1103' '#1073#1086#1083#1100#1096#1080#1093' '#1089#1091#1087#1077#1088#1086#1074' Pe_idBase, '#1076#1083#1103' '#1086#1089#1090#1072#1083#1100#1085#1099#1093' Pe_Id - '#1090 +
                '.'#1077'. '#1086#1080#1092#1089#1085#1099#1081' '#1082#1086#1076' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
              
                '@PersonLocal - '#1074#1089#1077#1075#1076#1072'  Pe_Id ('#1076#1072#1078#1077' '#1076#1083#1103' '#1073#1086#1083#1100#1096#1080#1093' '#1089#1091#1087#1077#1088#1086#1074' - '#1075#1076#1077' '#1101#1090#1086 +
                ' '#1083#1086#1082#1072#1083#1100#1085#1099#1081' '#1089#1086#1090#1088#1091#1076#1085#1080#1082')'
              
                'UserReallyAll - '#1074#1080#1076' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1087#1088#1072#1074' ('#1074#1089#1077' '#1087#1088#1072#1074#1072' '#1082#1086#1090#1086#1088#1099#1077' '#1077#1089#1090#1100' '#1091' ' +
                #1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103')'
              '')
            ReadOnly = True
            MemoAttrs = <
              item
                KeywordsList = klOperators
                MemoFontItem = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
                Name = #1041#1072#1079#1086#1074#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              end
              item
                Keywords = '@login,@person,@r,@personlocal,fnexistsgroup'
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
            OnChange = smSMBigChange
            ExplicitLeft = 1
            ExplicitTop = -1
          end
        end
        object TabSheet3: TTabSheet
          Caption = #1048#1089#1090#1086#1088#1080#1103
          ImageIndex = 38
          object cxGrid3: TcxGrid
            Left = 0
            Top = 0
            Width = 106
            Height = 306
            Align = alLeft
            TabOrder = 0
            object cxGrid3DBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
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
              object cxGrid3DBTableView1Column1: TcxGridDBColumn
                Caption = #1044#1072#1090#1072
                DataBinding.FieldName = 'URAL_EventTime'
                HeaderAlignmentHorz = taCenter
              end
            end
            object cxGrid3Level1: TcxGridLevel
              GridView = cxGrid3DBTableView1
            end
          end
          object Panel3: TPanel
            Left = 106
            Top = 0
            Width = 824
            Height = 306
            Align = alClient
            TabOrder = 1
            object Panel8: TPanel
              Left = 1
              Top = 235
              Width = 822
              Height = 70
              Align = alBottom
              TabOrder = 0
              object DBEdit10: TDBEdit
                Left = 513
                Top = 46
                Width = 139
                Height = 21
                TabStop = False
                DataField = 'URAL_EventTime'
                ReadOnly = True
                TabOrder = 0
              end
              object cxDBLabel1: TcxDBLabel
                Left = 35
                Top = 45
                DataBinding.DataField = 'URAL_Event'
                Height = 21
                Width = 54
              end
              object DBEdit3: TDBEdit
                Left = 48
                Top = 0
                Width = 84
                Height = 21
                TabStop = False
                DataField = 'URAL_Code_Old'
                ReadOnly = True
                TabOrder = 2
              end
              object DBEdit4: TDBEdit
                Left = 1
                Top = 22
                Width = 324
                Height = 21
                TabStop = False
                DataField = 'URAL_Name_Old'
                ReadOnly = True
                TabOrder = 3
              end
              object DBEdit5: TDBEdit
                Left = 377
                Top = 0
                Width = 84
                Height = 21
                TabStop = False
                DataField = 'URAL_Code_New'
                ReadOnly = True
                TabOrder = 4
              end
              object DBEdit6: TDBEdit
                Left = 328
                Top = 22
                Width = 324
                Height = 21
                TabStop = False
                DataField = 'URAL_Name_New'
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
                DataBinding.DataField = 'URAL_HOSTNAME'
                TabOrder = 10
                Height = 17
                Width = 177
              end
              object cxDBMemo2: TcxDBMemo
                Left = 383
                Top = 46
                DataBinding.DataField = 'URAL_LoginName'
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
            object Panel9: TPanel
              Left = 1
              Top = 1
              Width = 822
              Height = 229
              Align = alClient
              TabOrder = 1
              object Splitter3: TSplitter
                Left = 321
                Top = 1
                Width = 5
                Height = 227
                ExplicitHeight = 197
              end
              object fsSyntaxMemo5: TSyntaxMemo
                Left = 326
                Top = 1
                Width = 495
                Height = 227
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
                ExplicitHeight = 247
              end
              object fsSyntaxMemo4: TSyntaxMemo
                Left = 1
                Top = 1
                Width = 320
                Height = 227
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
            object cxSplitter1: TcxSplitter
              Left = 1
              Top = 230
              Width = 822
              Height = 5
              AlignSplitter = salBottom
              AutoSnap = True
              Control = Panel8
            end
          end
        end
      end
    end
  end
  object dsUserRightAccess: TDataSource
    DataSet = qryUserRightAccessEdit
    Left = 512
    Top = 80
  end
  object qryUserRightAccessEdit: TADOQuery
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
      'SELECT '
      '  *'
      'FROM'
      '  UserRightAccessShop'
      'WHERE'
      '  URAS_ID = :ID')
    Left = 512
    Top = 128
  end
  object qUser1: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SQL'
        Size = -1
        Value = Null
      end
      item
        Name = 'hideDis'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE'
      '   @SQL    NVARCHAR (MAX),'
      '   @R      BIT,'
      '   @cMsg   VARCHAR (1000)'
      'DECLARE @P   TABLE (Pe_ID    INT, Ur_ID    INT, IsAccess    BIT)'
      'DECLARE'
      '   @Person        INT,'
      '   @Subdivision   INT,'
      '   @Depart        INT,'
      '   @Login         INT,'
      '   @PersonLocal   INT,'
      '   @Ur_Name       VARCHAR (100)'
      'DECLARE @IsHideDis   BIT = 0'
      'SET @SQL = :SQL'
      'SET @IsHideDis = :hideDis'
      ''
      ''
      'DECLARE @IsBig   BIT'
      'DECLARE @ExecSQL   NVARCHAR (MAX) = '#39#39
      ''
      'IF object_id ('#39'tempdb..#Temp'#39') IS NOT NULL'
      '   DROP TABLE #Temp'
      ''
      'CREATE TABLE #Temp'
      '('
      '   IsBig    BIT'
      ')'
      ''
      'SET @IsBig = 0'
      ''
      'IF EXISTS'
      '      (SELECT *'
      '       FROM sys.columns c'
      
        '            INNER JOIN sys.objects o ON o.object_id = c.object_i' +
        'd'
      
        '       WHERE c.[name] = '#39'Con_CadreSmall'#39' AND o.[name] = '#39'config'#39 +
        ')'
      '   BEGIN'
      '      SET @ExecSQL ='
      
        '             '#39'insert into #Temp(IsBig) SELECT iif(Con_CadreSmall' +
        '= 1,0,1) FROM config'#39
      '      EXEC sp_ExecuteSQL @ExecSQL'
      '      SELECT @IsBig = IsBig FROM #Temp'
      '   END'
      'ELSE'
      '   SELECT @IsBig = 0'
      ''
      'IF object_id ('#39'tempdb..#VPerson'#39') IS NOT NULL'
      '   DROP TABLE #VPerson'
      ''
      'CREATE TABLE #VPerson'
      '('
      '   Pe_Id           INT NOT NULL,'
      '   Pe_IDBase       INT,'
      '   Pe_Discharge    SMALLDATETIME NULL,'
      '   Pe_Name         VARCHAR (255) NOT NULL'
      ')'
      ''
      'IF @IsBig = 1'
      '   SET @ExecSQL ='
      
        '          '#39'INSERT INTO #VPerson (Pe_Id, Pe_IDBase, Pe_Discharge,' +
        ' Pe_Name) SELECT Pe_Id, Pe_IDBase, Pe_Discharge, Pe_Name FROM VP' +
        'erson'#39
      'ELSE'
      '   SET @ExecSQL ='
      
        '          '#39'INSERT INTO #VPerson (Pe_Id, Pe_IDBase, Pe_Discharge,' +
        ' Pe_Name) SELECT Pe_Id, Pe_Id AS Pe_IDBase, Pe_Discharge, Pe_Nam' +
        'e FROM VPerson'#39
      ''
      'EXEC sp_ExecuteSQL @ExecSQL'
      ''
      'IF @SQL = '#39#39
      '   BEGIN'
      '      SELECT Pe_Name AS Pe_FullName,'
      '             '#39'-'#39' AS IsAccessStr,'
      
        '             STUFF ((SELECT '#39','#39' + cast (GR_Name AS VARCHAR) AS [' +
        'text()]'
      '                     FROM (SELECT DISTINCT GR_Name'
      '                           FROM UserGroupMember'
      '                           WHERE GR_User = Ur_ID) T'
      '                     FOR XML PATH('#39#39')),'
      '                    1,'
      '                    1,'
      '                    '#39#39') AS GR_Name,'
      '             *'
      '      FROM UserRight INNER JOIN #VPerson ON Ur_Person = Pe_Id'
      
        '      WHERE (@IsHideDis = 0) OR (@IsHideDis = 1 AND Pe_Discharge' +
        ' IS NULL)'
      '      ORDER BY Pe_Id'
      '   END'
      'ELSE'
      '   BEGIN'
      '      DECLARE'
      '         C1 CURSOR LOCAL FOR'
      '            SELECT UR_ID,'
      '                   Pe_ID,'
      '                   Pe_IDBase,'
      '                   UR_Name'
      
        '            FROM #VPerson INNER JOIN UserReallyAll ON UR_Person ' +
        '= Pe_ID'
      ''
      '      OPEN C1'
      '      FETCH NEXT FROM C1'
      '           INTO @Login,'
      '                @PersonLocal,'
      '                @Person,'
      '                @Ur_Name'
      ''
      '      WHILE @@FETCH_STATUS = 0'
      '      BEGIN'
      '         BEGIN TRY'
      '            SET @R = 0'
      '            EXEC'
      '               sp_ExecuteSQL @SQL,'
      
        '               N'#39'@Person int, @Login int, @PersonLocal int, @R b' +
        'it output'#39','
      '               @Person,'
      '               @Login,'
      '               @PersonLocal,'
      '               @R OUTPUT'
      ''
      '            IF @R = 1'
      '               INSERT INTO @P (Pe_ID, Ur_ID, IsAccess)'
      '               VALUES (@PersonLocal, @Login, 1)'
      '         END TRY'
      '         BEGIN CATCH'
      '            SET @cMsg ='
      
        '                     '#39#1054#1096#1080#1073#1082#1072' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1103' '#1079#1072#1087#1088#1086#1089#1072'...~~'#1057#1077#1088#1074#1077#1088' '#1086#1073#1085#1072#1088 +
        #1091#1078#1080#1083' '#1082#1088#1080#1074#1099#1077' '#1088#1091#1082#1080'...~'#39
      '                   + error_message ()'
      '            RAISERROR (@cMsg, 16, 10)'
      '            BREAK'
      '         END CATCH'
      ''
      '         FETCH NEXT FROM C1'
      '              INTO @Login,'
      '                   @PersonLocal,'
      '                   @Person,'
      '                   @Ur_Name'
      '      END'
      ''
      '      CLOSE C1'
      '      DEALLOCATE C1'
      ''
      '      SELECT Pe_Name AS Pe_FullName,'
      
        '             CASE WHEN IsAccess = 1 THEN '#39#1044#1072#39' ELSE '#39' '#39' END AS Is' +
        'AccessStr,'
      
        '             STUFF ((SELECT '#39','#39' + cast (GR_Name AS VARCHAR) AS [' +
        'text()]'
      '                     FROM (SELECT DISTINCT GR_Name'
      '                           FROM UserGroupMember'
      '                           WHERE GR_User = UR.Ur_ID) T'
      '                     FOR XML PATH('#39#39')),'
      '                    1,'
      '                    1,'
      '                    '#39#39') AS GR_Name,'
      '             *'
      '      FROM UserRight AS UR'
      '           INNER JOIN vPerson ON Ur_Person = Pe_Id'
      
        '           LEFT JOIN @P AS P1 ON P1.Pe_ID = Ur_Person AND P1.Ur_' +
        'ID = UR.Ur_ID'
      
        '      WHERE (@IsHideDis = 0) OR (@IsHideDis = 1 AND Pe_Discharge' +
        ' IS NULL)'
      '      ORDER BY isNull (IsAccess, 0) DESC, P1.Pe_Id'
      '   END')
    Left = 696
    Top = 136
  end
  object dsUser1: TDataSource
    DataSet = qUser1
    OnDataChange = dsUser1DataChange
    Left = 696
    Top = 200
  end
  object ImageList1: TImageList
    Left = 417
    Top = 265
    Bitmap = {
      494C010102000800800010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object MainMenu1: TMainMenu
    Images = DataModule1.il16
    Left = 680
    Top = 256
    object mm_Copy: TMenuItem
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1089#1090#1091#1087
      ImageIndex = 24
      OnClick = mm_CopyClick
    end
    object mm_CopyTest2: TMenuItem
      Tag = 1
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1083#1103' '#1090#1077#1089#1090#1080#1088#1086#1074#1097#1080#1082#1086#1074
      OnClick = mm_CopyClick
    end
    object N1: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object mm_ShopAdminListInfo: TMenuItem
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081
        OnClick = mm_ShopAdminListInfoClick
      end
    end
  end
  object qUser2: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SQL'
        Size = -1
        Value = Null
      end
      item
        Name = 'hideDis'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      #1050#1086#1076' '#1074' qUser1')
    Left = 776
    Top = 136
  end
  object dsUser2: TDataSource
    DataSet = qUser2
    OnDataChange = dsUser1DataChange
    Left = 776
    Top = 200
  end
  object qUser3: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SQL'
        Size = -1
        Value = Null
      end
      item
        Name = 'hideDis'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      #1050#1086#1076' '#1074' qUser1')
    Left = 848
    Top = 136
  end
  object dsUser3: TDataSource
    DataSet = qUser3
    OnDataChange = dsUser1DataChange
    Left = 848
    Top = 200
  end
  object qPlace: TADOQuery
    Connection = DataModule1.Connection
    Parameters = <
      item
        Name = 'SAPl_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'Data_Source'
        Size = -1
        Value = Null
      end
      item
        Name = 'Pl_Type'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DROP TABLE IF EXISTS #_PlaceForURAS'
      ''
      'CREATE TABLE #_PlaceForURAS'
      '('
      '   BDName                VARCHAR (100),'
      '   pl_Id                 INT,'
      '   Shop_Type             INT,'
      '   Pl_Name               VARCHAR (70),'
      '   Data_Source           VARCHAR (100),'
      '   PWD                   VARCHAR (100),'
      '   PlConnectionString    VARCHAR (1000)'
      ')'
      ''
      'INSERT INTO #_PlaceForURAS (BDName,'
      '                            pl_Id,'
      '                            Shop_Type,'
      '                            Pl_Name,'
      '                            Data_Source,'
      '                            PWD,'
      '                            PlConnectionString)'
      'EXEC pr_GetUserRightAccessShopPlace :SAPl_Id, :Data_Source, :Pl'
      ''
      'SELECT *'
      'FROM #_PlaceForURAS'
      'ORDER BY pl_Id')
    Left = 89
    Top = 217
  end
  object qCheckAccessShopText: TADOQuery
    Connection = DataModule1.Connection
    Parameters = <
      item
        Name = 'Login'
        Size = -1
        Value = Null
      end
      item
        Name = 'SQL'
        Size = -1
        Value = Null
      end
      item
        Name = 'Person'
        Size = -1
        Value = Null
      end
      item
        Name = 'PersonLocal'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE'
      '   @Login         INT,'
      '   @SQL           NVARCHAR (MAX),'
      '   @R             BIT = 0,'
      '   @Person        INT = 0,'
      '   @PersonLocal   INT = 0'
      ''
      'SET @Login = :Login'
      'SET @SQL = :SQL'
      'SET @Person = :Person'
      'SET @PersonLocal = :PersonLocal'
      ''
      'IF @Person = 0'
      '   SELECT @Person = Ur_Person'
      '   FROM UserRight'
      '   WHERE UR_ID = @Login'
      ''
      'DECLARE @IsBig   BIT'
      'DECLARE @ExecSQL   NVARCHAR (MAX) = '#39#39
      ''
      'IF object_id ('#39'tempdb..#Temp'#39') IS NOT NULL'
      '   DROP TABLE #Temp'
      ''
      'CREATE TABLE #Temp'
      '('
      '   IsBig    BIT'
      ')'
      ''
      'SET @IsBig = 0'
      ''
      'IF EXISTS'
      '      (SELECT *'
      
        '       FROM sys.columns c INNER JOIN sys.objects o ON o.object_i' +
        'd = c.object_id'
      
        '       WHERE c.[name] = '#39'Con_CadreSmall'#39' AND o.[name] = '#39'config'#39 +
        ')'
      '   BEGIN'
      
        '      SET @ExecSQL = '#39'INSERT INTO #Temp(IsBig) SELECT IIF(Con_Ca' +
        'dreSmall= 1,0,1) FROM config'#39
      '      EXEC sp_ExecuteSQL @ExecSQL'
      '      SELECT @IsBig = IsBig FROM #Temp'
      '   END'
      'ELSE'
      '   SELECT @IsBig = 0'
      ''
      'IF object_id ('#39'tempdb..#VPerson'#39') IS NOT NULL'
      '   DROP TABLE #VPerson'
      ''
      'CREATE TABLE #VPerson'
      '('
      '   Pe_IDBase    INT NOT NULL,'
      ''
      ')'
      ''
      'IF @Person <> 0'
      '   IF @IsBig = 1'
      '      BEGIN'
      '         SET @ExecSQL ='
      
        '                  '#39'INSERT INTO #VPerson (Pe_IDBase) SELECT Pe_ID' +
        'Base FROM VPerson WHERE Pe_Id = '#39
      '                + CAST (@PersonLocal AS VARCHAR)'
      '         EXEC sp_ExecuteSQL @ExecSQL'
      '         SELECT @Person = Pe_IDBase FROM #VPerson'
      '      END'
      '   ELSE'
      '      SET @Person = @PersonLocal'
      ''
      'EXEC'
      '   sp_ExecuteSQL @SQL,'
      '   N'#39'@Login int, @Person int,@PersonLocal int, @R bit output'#39','
      '   @Login,'
      '   @Person,'
      '   @PersonLocal,'
      '   @R OUTPUT'
      ''
      'SELECT @R res ')
    Left = 217
    Top = 217
  end
  object qUnloadLog: TADOQuery
    Connection = DataModule1.Connection
    Parameters = <
      item
        Name = 'SDoc'
        Size = -1
        Value = Null
      end
      item
        Name = 'SAPl_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'Data_Source'
        Size = -1
        Value = Null
      end
      item
        Name = 'Pl_Type'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE @Id   INT = :SDoc'
      'DROP TABLE IF EXISTS #_PlaceForURAS'
      ''
      'CREATE TABLE #_PlaceForURAS'
      '('
      '   BDName                VARCHAR (100),'
      '   pl_Id                 INT,'
      '   Shop_Type             INT,'
      '   Pl_Name               VARCHAR (70),'
      '   Data_Source           VARCHAR (100),'
      '   PWD                   VARCHAR (100),'
      '   PlConnectionString    VARCHAR (1000)'
      ')'
      ''
      'INSERT INTO #_PlaceForURAS (BDName,'
      '                            pl_Id,'
      '                            Shop_Type,'
      '                            Pl_Name,'
      '                            Data_Source,'
      '                            PWD,'
      '                            PlConnectionString)'
      
        'EXEC pr_GetUserRightAccessShopPlace :SAPl_Id, :Data_Source, :Pl_' +
        'Type'
      ''
      ''
      'SELECT pl_Id,'
      '       Pl_Name,'
      '       BDName,'
      '       Data_Source,'
      '       PWD,'
      '       PlConnectionString,'
      '       URAS_DateUpdate,'
      '       URAUL_URAS_DateUpdate,'
      '       URAUL_ErrMsg,'
      '       CASE'
      '          WHEN CONVERT (VARCHAR, URAS_DateUpdate, 20) ='
      
        '               CONVERT (VARCHAR, IsNull (URAUL_URAS_DateUpdate, ' +
        'getdate ()), 20)'
      '          THEN'
      '             cast (1 AS BIT)'
      '          ELSE'
      '             cast (0 AS BIT)'
      '       END AS URAUL_Success,'
      '       URAUL_UnloadTime'
      'FROM #_PlaceForURAS p1'
      '     CROSS APPLY (SELECT *'
      '                  FROM UserRightAccessShop'
      '                  WHERE URAS_Id = @Id) t1'
      '     OUTER APPLY (SELECT *'
      '                  FROM UserRightAccessShopUnloadLog'
      
        '                  WHERE URAUL_SDoc = @Id AND URAUL_Pl_Id = Pl_Id' +
        ') t2'
      'ORDER BY pl_Id')
    Left = 193
    Top = 329
  end
  object dsUnloadLog: TDataSource
    DataSet = qUnloadLog
    OnDataChange = dsUser1DataChange
    Left = 192
    Top = 296
  end
  object qPing: TADOQuery
    Connection = DataModule1.Connection
    CommandTimeout = 300
    Parameters = <
      item
        Name = 'Data_Source'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE'
      '   @Server   NVARCHAR (MAX),'
      '   @Res      BIT'
      'SET @Server = :Data_Source'
      'SET @Res = 0'
      'EXECUTE electro.dbo.PingServer @Server, @Res OUTPUT'
      ''
      'SELECT @Res AS Res')
    Left = 528
    Top = 288
  end
end

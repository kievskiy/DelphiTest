object fmUserRightAccessShopList: TfmUserRightAccessShopList
  Left = 0
  Top = 0
  Caption = #1056#1077#1077#1089#1090#1088' '#1076#1086#1089#1090#1091#1087#1086#1074' '#1085#1072' '#1058#1058
  ClientHeight = 423
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 423
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfStandard
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnDblClick = actEditExecute
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsUserRightAccess
      DataController.DetailKeyFieldNames = 'URAS_ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = DataModule1.il16
      OptionsBehavior.IncSearch = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Preview.Visible = True
      object cxGrid1DBTableView1URAS_Code: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'URAS_Code'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
      end
      object cxGrid1DBTableView1URAS_Name: TcxGridDBColumn
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        DataBinding.FieldName = 'URAS_Name'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 506
      end
      object cxGrid1DBTableView1_Success: TcxGridDBColumn
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
        DataBinding.FieldName = '_Success'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = DataModule1.il16
        Properties.Items = <
          item
            Description = #1040#1082#1090#1091#1072#1083#1100#1085#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1085#1072' '#1074#1089#1077#1093' '#1058#1058
            ImageIndex = 21
            Value = True
          end
          item
            Description = #1053#1077' '#1085#1072' '#1074#1089#1077#1093' '#1058#1058' '#1072#1082#1090#1091#1072#1083#1100#1085#1072#1103' '#1080#1085#1092#1072
            ImageIndex = 25
            Value = False
          end>
        Properties.ShowDescriptions = False
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 57
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object qryUserRightAccess: TADOQuery
    Connection = DataModule1.Connection
    CursorType = ctStatic
    Parameters = <
      item
        Name = '_SAPl_Id'
        Size = -1
        Value = Null
      end
      item
        Name = '_Data_Source'
        Size = -1
        Value = Null
      end
      item
        Name = '_IsActive'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'DECLARE'
      '   @SAPl_Id       INT,'
      '   @Data_Source   NVARCHAR (MAX),'
      '   @IsActive         INT'
      'SET @SAPl_Id = :_SAPl_Id'
      'SET @Data_Source = :_Data_Source'
      'SET @IsActive = :_IsActive'
      'DROP TABLE IF EXISTS #PlaceForURAS'
      ''
      ''
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
      'EXEC pr_GetUserRightAccessShopPlace @SAPl_Id, @Data_Source, 0'
      ''
      'SELECT *'
      'INTO #PlaceForURAS'
      'FROM #_PlaceForURAS'
      ''
      'ALTER TABLE #PlaceForURAS'
      '   ADD _IsActive BIT NOT NULL DEFAULT 0'
      'DROP TABLE IF EXISTS #Temp_URAS_Result'
      ''
      'SELECT URAS_Id,'
      '       pl_Id,'
      '       CASE'
      '          WHEN CONVERT (VARCHAR, URAS_DateUpdate, 20) ='
      '               CONVERT'
      
        '               (VARCHAR, IsNull (URAUL_URAS_DateUpdate, getdate ' +
        '()), 20)'
      '          THEN'
      '             cast (1 AS BIT)'
      '          ELSE'
      '             cast (0 AS BIT)'
      '       END AS URAUL_Success'
      'INTO #Temp_URAS_Result'
      'FROM #PlaceForURAS p1'
      '     CROSS APPLY (SELECT * FROM UserRightAccessShop) t1'
      '     OUTER APPLY (SELECT *'
      '                  FROM UserRightAccessShopUnloadLog'
      
        '                  WHERE URAUL_SDoc = URAS_Id AND URAUL_Pl_Id = P' +
        'l_Id) t2'
      ''
      'SELECT u.*,'
      
        '       CASE WHEN _Success = 0 THEN cast (0 AS BIT) ELSE cast (1 ' +
        'AS BIT) END AS _Success'
      'FROM UserRightAccessShop u'
      '     OUTER APPLY (SELECT DISTINCT cast (0 AS BIT) AS _Success'
      '                  FROM #Temp_URAS_Result t1'
      
        '                  WHERE t1.URAS_Id = u.URAS_Id AND URAUL_Success' +
        ' = 0) o'
      'WHERE (URAS_IsDel = @IsActive) OR (@IsActive = -1)'
      'ORDER BY URAS_Code'
      '')
    Left = 208
    Top = 112
  end
  object dsUserRightAccess: TDataSource
    DataSet = qryUserRightAccess
    Left = 192
    Top = 168
  end
  object mm1: TMainMenu
    Images = DataModule1.il16
    Left = 400
    Top = 168
    object mm_Filter: TMenuItem
      Caption = #1060#1080#1083#1100#1090#1088
      ImageIndex = 12
      object N7: TMenuItem
        Caption = #1055#1086' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080
        object mmFAll: TMenuItem
          Tag = -1
          Caption = #1042#1089#1077
          OnClick = mmFAllClick
        end
        object N8: TMenuItem
          Caption = #1040#1082#1090#1080#1074#1085#1099#1077
          OnClick = mmFAllClick
        end
        object N9: TMenuItem
          Tag = 1
          Caption = #1059#1076#1072#1083#1105#1085#1085#1099#1077
          OnClick = mmFAllClick
        end
      end
    end
    object N1: TMenuItem
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      ImageIndex = 70
      ShortCut = 116
      OnClick = actRefreshExecute
    end
    object N2: TMenuItem
      Caption = #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 67
      ShortCut = 45
      OnClick = actAddExecute
    end
    object N3: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 69
      OnClick = actEditExecute
    end
    object N4: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 68
      ShortCut = 46
      OnClick = actDelExecute
    end
    object N5: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1100
      ImageIndex = 4
    end
    object N6: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 24
    end
    object mm_Log: TMenuItem
      Caption = #1048#1089#1090#1086#1088#1080#1103
      OnClick = mm_LogClick
    end
    object mm_Job: TMenuItem
      Caption = 'Job'
      OnClick = mm_JobClick
    end
  end
end

object DataM: TDataM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 198
  Top = 173
  Height = 150
  Width = 179
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\BDD.mdb;Persist S' +
      'ecurity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 72
  end
  object ADOTable: TADOTable
    Connection = ADOConnection
    TableName = 'Fournisseurs'
    Left = 24
    Top = 56
    object ADOTableN: TAutoIncField
      FieldName = 'N'#176
      ReadOnly = True
    end
    object ADOTableORDRE: TWideStringField
      FieldName = 'ORDRE'
    end
    object ADOTableCODE_FOUR: TWideStringField
      FieldName = 'CODE_FOUR'
      Size = 50
    end
    object ADOTableNOM_ENTREPRISE: TWideStringField
      FieldName = 'NOM_ENTREPRISE'
      Size = 50
    end
    object ADOTableSTATUT: TWideStringField
      FieldName = 'STATUT'
      Size = 40
    end
    object ADOTableDOMAINE: TWideStringField
      FieldName = 'DOMAINE'
      Size = 40
    end
    object ADOTablePRODUITS: TWideStringField
      FieldName = 'PRODUITS'
      Size = 50
    end
    object ADOTableNOM_FOUR: TWideStringField
      FieldName = 'NOM_FOUR'
      Size = 40
    end
    object ADOTablePRENOM_FOUR: TWideStringField
      FieldName = 'PRENOM_FOUR'
      Size = 40
    end
    object ADOTableADRESSE: TMemoField
      FieldName = 'ADRESSE'
      BlobType = ftMemo
    end
    object ADOTableVILLE: TWideStringField
      FieldName = 'VILLE'
      Size = 40
    end
    object ADOTableTELEPHONE: TWideStringField
      FieldName = 'TELEPHONE'
      Size = 30
    end
    object ADOTableFAX: TWideStringField
      FieldName = 'FAX'
      Size = 30
    end
    object ADOTableE_MAIL: TWideStringField
      FieldName = 'E_MAIL'
      Size = 40
    end
    object ADOTableSITE_INTERNET: TWideStringField
      FieldName = 'SITE_INTERNET'
      Size = 40
    end
    object ADOTableETS_BANCAIRE: TWideStringField
      FieldName = 'ETS_BANCAIRE'
      Size = 50
    end
    object ADOTableCPT_BANCAIRE: TWideStringField
      FieldName = 'CPT_BANCAIRE'
      Size = 50
    end
    object ADOTableREG_COMMERCE: TWideStringField
      FieldName = 'REG_COMMERCE'
      Size = 50
    end
    object ADOTableIDENTIFIANT_FISCAL: TWideStringField
      FieldName = 'IDENTIFIANT_FISCAL'
      Size = 50
    end
    object ADOTableART_IMPOSITION: TWideStringField
      FieldName = 'ART_IMPOSITION'
      Size = 50
    end
    object ADOTableDATE_CRE_FICHE: TDateTimeField
      FieldName = 'DATE_CRE_FICHE'
    end
    object ADOTableREMARQUES: TMemoField
      FieldName = 'REMARQUES'
      BlobType = ftMemo
    end
    object ADOTableMONTANT: TBCDField
      FieldName = 'MONTANT'
      Precision = 19
    end
    object ADOTableBLOQUE: TBooleanField
      FieldName = 'BLOQUE'
    end
  end
  object DataSource: TDataSource
    DataSet = ADOTable
    Left = 112
    Top = 56
  end
end

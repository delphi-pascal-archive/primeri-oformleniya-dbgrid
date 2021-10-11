unit FrmDataModule;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataM = class(TDataModule)
    ADOConnection: TADOConnection;
    ADOTable: TADOTable;
    DataSource: TDataSource;
    ADOTableN: TAutoIncField;
    ADOTableORDRE: TWideStringField;
    ADOTableCODE_FOUR: TWideStringField;
    ADOTableNOM_ENTREPRISE: TWideStringField;
    ADOTableSTATUT: TWideStringField;
    ADOTableDOMAINE: TWideStringField;
    ADOTablePRODUITS: TWideStringField;
    ADOTableNOM_FOUR: TWideStringField;
    ADOTablePRENOM_FOUR: TWideStringField;
    ADOTableADRESSE: TMemoField;
    ADOTableVILLE: TWideStringField;
    ADOTableTELEPHONE: TWideStringField;
    ADOTableFAX: TWideStringField;
    ADOTableE_MAIL: TWideStringField;
    ADOTableSITE_INTERNET: TWideStringField;
    ADOTableETS_BANCAIRE: TWideStringField;
    ADOTableCPT_BANCAIRE: TWideStringField;
    ADOTableREG_COMMERCE: TWideStringField;
    ADOTableIDENTIFIANT_FISCAL: TWideStringField;
    ADOTableART_IMPOSITION: TWideStringField;
    ADOTableDATE_CRE_FICHE: TDateTimeField;
    ADOTableREMARQUES: TMemoField;
    ADOTableMONTANT: TBCDField;
    ADOTableBLOQUE: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DataM: TDataM;

implementation

{$R *.dfm}

procedure TDataM.DataModuleCreate(Sender: TObject);
begin
 // Désactiver la connection
 ADOConnection.Connected:=False;
 // Spécifier les paramètres d'AdoConnection
 AdoConnection.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;'+
                                'Data Source=.\BDD.mdb;Persist Security Info=False'+
                                'Mode=Share Deny None;Extended Properties="";'+
                                'Persist Security Info=False;Jet OLEDB:System database="";'+
                                'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";';
 // Activer la connection
 AdoConnection.Connected:=True;
 // Ouvrir la table des fournisseurs
 ADoTable.Open;
end;

end.

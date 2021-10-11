program EUDBGrid;

uses
  Forms,
  AFirstPage in 'AFirstPage.pas' {Fournisseurs},
  FrmDataModule in 'FrmDataModule.pas' {DataM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFournisseurs, Fournisseurs);
  Application.CreateForm(TDataM, DataM);
  Application.Run;
end.

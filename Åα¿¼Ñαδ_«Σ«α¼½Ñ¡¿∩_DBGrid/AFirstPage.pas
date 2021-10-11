unit AFirstPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, Grids, DBGrids, Menus,DB,
  ImgList,DBTables,AdoDB;

type
  TFournisseurs = class(TForm)
    GroupBox: TGroupBox;
    DBGrid: TDBGrid;
    PMP: TPopupMenu;
    outslectionner1: TMenuItem;
    Dsactivertout1: TMenuItem;
    N1: TMenuItem;
    ExporterCSV1: TMenuItem;
    N2: TMenuItem;
    otal1: TMenuItem;
    SD: TSaveDialog;
    ImageList: TImageList;
    N3: TMenuItem;
    Propriets1: TMenuItem;
    Sauvegarderlesparamtres1: TMenuItem;
    lchargerlesparamtres1: TMenuItem;
    ButtonGroupBox: TGroupBox;
    DBNFirst: TDBNavigator;
    DBNPrior: TDBNavigator;
    BBAdd: TBitBtn;
    BBEdit: TBitBtn;
    BBDelete: TBitBtn;
    BBLocked: TBitBtn;
    DBNNext: TDBNavigator;
    DBNLast: TDBNavigator;
    N4: TMenuItem;
    Listechamps1: TMenuItem;
    procedure BBAddClick(Sender: TObject);
    procedure BBEditClick(Sender: TObject);
    procedure BBDeleteClick(Sender: TObject);
    procedure outslectionner1Click(Sender: TObject);
    procedure Dsactivertout1Click(Sender: TObject);
    procedure ExporterCSV1Click(Sender: TObject);
    procedure otal1Click(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BBLockedClick(Sender: TObject);
    procedure Propriets1Click(Sender: TObject);
    procedure lchargerlesparamtres1Click(Sender: TObject);
    procedure Sauvegarderlesparamtres1Click(Sender: TObject);
    procedure Listechamps1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fournisseurs: TFournisseurs;

implementation

uses FrmDataModule;

type
  AlternGrid = class(TCustomDBGrid);
{$R *.dfm}
// Procedure pour selectionner les lignes de DBGrid
function GridSelectAll(Grid: TDBGrid): Longint;
begin
  Result := 0;
  Grid.SelectedRows.Clear;
  with Grid.DataSource.DataSet do
  begin
    First;
    DisableControls;
    try
      while not EOF do
      begin
        Grid.SelectedRows.CurrentRowSelected := True;
        Inc(Result);
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;

// Créer la liste des fonts
function GetFontList:Tstrings;
var
 screen :Tscreen;
begin
 screen := Tscreen.Create(nil);
 Getfontlist := screen.fonts;
end;

procedure TFournisseurs.BBAddClick(Sender: TObject);
var Ajouter: TForm;
    Ordre,CodeF,NomE,Statut,Domaine,Pts,Nom,Prenom:TEdit;
begin

// Créer les zones de texte "Edits"
 Ordre:=TEdit.Create(Nil);
 CodeF:=TEdit.Create(Nil);
 NomE:=TEdit.Create(Nil);
 Statut:=TEdit.Create(Nil);
 Domaine:=TEdit.Create(Nil);
 Pts:=TEdit.Create(Nil);
 Nom:=TEdit.Create(Nil);
 Prenom:=TEdit.Create(Nil);

// Créer le message ajouter nouveau enregistrement (#13= Sauter la ligne entrer)

 Ajouter := CreateMessageDialog('Ajouter un nouveau fournisseur                                     '+#13+#13+#13+
                                'Ordre                                                              '+#13+#13+#13+
                                'Code fournisseur                                                   '+#13+#13+#13+
                                'Nom d''Entreprise                                                  '+#13+#13+#13+
                                'Statut                                                             '+#13+#13+#13+
                                'Domaine                                                            '+#13+#13+#13+
                                'Produits                                                           '+#13+#13+#13+
                                'Nom                                                                '+#13+#13+#13+
                                'Prénom                                                              '+#13+#13
                                , mtInformation,[mbYes, mbCancel]);
 with Ajouter do
 try
 // Modifier le titre de le fenetre
 Caption := 'Ajouter nouveau fournisseur';

 // Modifier la position de la zone Odre
 Ordre.Parent:=Ajouter;
 Ordre.Left:=55;
 Ordre.Top:=68;
 Ordre.Width:=100;
 Ordre.Height:=30;

 // Modifier la position de la zone Code FOURNISSEUR
 CodeF.Parent:=Ajouter;
 CodeF.Left:=55;
 CodeF.Top:=108;
 CodeF.Width:=150;
 CodeF.Height:=40;

 // Modifier la position de la zone Nom de l'entreprise
 NomE.Parent:=Ajouter;
 NomE.Left:=55;
 NomE.Top:=148;
 NomE.Width:=150;
 NomE.Height:=30;

 // Modifier la position de la zone Statut juridique
 Statut.Parent:=Ajouter;
 Statut.Left:=55;
 Statut.Top:=188;
 Statut.Width:=150;
 Statut.Height:=30;

 // Modifier la position de la zone Domaine d'activité
 Domaine.Parent:=Ajouter;
 Domaine.Left:=55;
 Domaine.Top:=228;
 Domaine.Width:=150;
 Domaine.Height:=30;

 // Modifier la position de la zone Produits
 Pts.Parent:=Ajouter;
 Pts.Left:=55;
 Pts.Top:=263;
 Pts.Width:=250;
 Pts.Height:=30;

 // Modifier la position de la zone Nom de fournisseur
 Nom.Parent:=Ajouter;
 Nom.Left:=55;
 Nom.Top:=300;
 Nom.Width:=100;
 Nom.Height:=30;

 // Modifier la position de la zone Prénom de fournisseur
 Prenom.Parent:=Ajouter;
 Prenom.Left:=55;
 Prenom.Top:=340;
 Prenom.Width:=100;
 Prenom.Height:=30;

if (ShowModal = ID_YES) then
Begin
With DataM.ADOTable Do
begin
// Mettre la table sur nouveau enregistrement
   Append;
// Donner la valeur de chaque champs ici on peux utiliser soit Fields[...] soit FieldsByName(...)
   Fields[1].Value:=Ordre.Text;
   Fields[2].Value:=CodeF.Text;
   Fields[3].Value:=NomE.Text;
   Fields[4].Value:=Statut.Text;
   Fields[5].Value:=Domaine.Text;
   Fields[6].Value:=Pts.Text;
   Fields[7].Value:=Nom.Text;
   Fields[8].Value:=Prenom.Text;
// Valider l'enregistrement
   Post;
end;
end;
 finally
 // Libérer les compos crées ainsi que la fiche ajouter
    Ordre.Free;
    CodeF.Free;
    NomE.Free;
    Statut.Free;
    Domaine.Free;
    Pts.Free;
    Nom.Free;
    Prenom.Free;
    Ajouter.Free;
end;

end;

procedure TFournisseurs.BBEditClick(Sender: TObject);
var Modifier: TForm;
    Ordre,CodeF,NomE,Statut,Domaine,Pts,Nom,Prenom:TEdit;
begin

// Créer les zones de texte "Edits"
 Ordre:=TEdit.Create(Nil);
 CodeF:=TEdit.Create(Nil);
 NomE:=TEdit.Create(Nil);
 Statut:=TEdit.Create(Nil);
 Domaine:=TEdit.Create(Nil);
 Pts:=TEdit.Create(Nil);
 Nom:=TEdit.Create(Nil);
 Prenom:=TEdit.Create(Nil);

// Créer le message ajouter nouveau enregistrement (#13= Sauter la ligne entrer)

 Modifier := CreateMessageDialog('Modifier le fournisseur                                           '+#13+#13+#13+
                                'Ordre                                                              '+#13+#13+#13+
                                'Code fournisseur                                                   '+#13+#13+#13+
                                'Nom d''Entreprise                                                  '+#13+#13+#13+
                                'Statut                                                             '+#13+#13+#13+
                                'Domaine                                                            '+#13+#13+#13+
                                'Produits                                                           '+#13+#13+#13+
                                'Nom                                                                '+#13+#13+#13+
                                'Prénom                                                              '+#13+#13
                                , mtInformation,[mbYes, mbCancel]);
 with Modifier do
 try
 // Modifier le titre de le fenetre
 Caption := 'Modifier le fournisseur';

 // Modifier la position de la zone Odre
 Ordre.Parent:=Modifier;
 Ordre.Left:=55;
 Ordre.Top:=68;
 Ordre.Width:=100;
 Ordre.Height:=30;

 // Modifier la position de la zone Code FOURNISSEUR
 CodeF.Parent:=Modifier;
 CodeF.Left:=55;
 CodeF.Top:=108;
 CodeF.Width:=150;
 CodeF.Height:=40;

 // Modifier la position de la zone Nom de l'entreprise
 NomE.Parent:=Modifier;
 NomE.Left:=55;
 NomE.Top:=148;
 NomE.Width:=150;
 NomE.Height:=30;

 // Modifier la position de la zone Statut juridique
 Statut.Parent:=Modifier;
 Statut.Left:=55;
 Statut.Top:=188;
 Statut.Width:=150;
 Statut.Height:=30;

 // Modifier la position de la zone Domaine d'activité
 Domaine.Parent:=Modifier;
 Domaine.Left:=55;
 Domaine.Top:=228;
 Domaine.Width:=150;
 Domaine.Height:=30;

 // Modifier la position de la zone Produits
 Pts.Parent:=Modifier;
 Pts.Left:=55;
 Pts.Top:=263;
 Pts.Width:=250;
 Pts.Height:=30;

 // Modifier la position de la zone Nom de fournisseur
 Nom.Parent:=Modifier;
 Nom.Left:=55;
 Nom.Top:=300;
 Nom.Width:=100;
 Nom.Height:=30;

 // Modifier la position de la zone Prénom de fournisseur
 Prenom.Parent:=Modifier;
 Prenom.Left:=55;
 Prenom.Top:=340;
 Prenom.Width:=100;
 Prenom.Height:=30;

// Remplir les valeurs de chaque zone de texte
Ordre.Text:= DataM.ADOTable.Fields[1].AsString;
CodeF.Text:= DataM.ADOTable.Fields[2].AsString;
NomE.Text:= DataM.ADOTable.Fields[3].AsString;
Statut.Text:= DataM.ADOTable.Fields[4].AsString;
Domaine.Text:= DataM.ADOTable.Fields[5].AsString;
Pts.Text:= DataM.ADOTable.Fields[6].AsString;
Nom.Text:= DataM.ADOTable.Fields[7].AsString;
Prenom.Text:= DataM.ADOTable.Fields[8].AsString;

if (ShowModal = ID_YES) then
Begin
With DataM.ADOTable Do
begin
// Mettre la table mode edition = modification
   Edit;
// Donner la valeur de chaque champs ici on peux utiliser soit Fields[...] soit FieldsByName(...)
   Fields[1].Value:=Ordre.Text;
   Fields[2].Value:=CodeF.Text;
   Fields[3].Value:=NomE.Text;
   Fields[4].Value:=Statut.Text;
   Fields[5].Value:=Domaine.Text;
   Fields[6].Value:=Pts.Text;
   Fields[7].Value:=Nom.Text;
   Fields[8].Value:=Prenom.Text;
// Valider l'enregistrement
   Post;
end;
end;
 finally
 // Libérer les compos crées ainsi que la fiche ajouter
    Ordre.Free;
    CodeF.Free;
    NomE.Free;
    Statut.Free;
    Domaine.Free;
    Pts.Free;
    Nom.Free;
    Prenom.Free;
    Modifier.Free;
end;

end;

procedure TFournisseurs.BBDeleteClick(Sender: TObject);
begin
if MessageDlg('Etes-vous sûr de vouloir supprimer cet fournisseur ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  DataM.ADOTable.Delete;
end;

procedure TFournisseurs.outslectionner1Click(Sender: TObject);
begin
// Sélectionner toutes les lignes voir la procédure
GridSelectAll(DBGrid);
end;

procedure TFournisseurs.Dsactivertout1Click(Sender: TObject);
begin
// Désactiver la sélection
DBGrid.SelectedRows.Clear;
end;

procedure TFournisseurs.ExporterCSV1Click(Sender: TObject);
var
  i: Integer;
  sum : Single;
  SListe:TStringList;
begin
Try
// condition = s'il ya des lignes sélectionnées
  if DBGrid.SelectedRows.Count > 0 then
  begin
  // Créer la liste
  SListe:=TStringList.Create;
  // Ajouter la première ligne entête de lignes
        SListe.Add('Ordre;'+
                   'Code fournisseur;'+
                   'Nom Entreprise;'+
                   'Statut;'+
                   'Domaine;'+
                   'Produits;'+
                   'Nom;'+
                   'Prenom;');

    with DBGrid.DataSource.DataSet do
    begin
      for i := 0 to DBGrid.SelectedRows.Count-1 do
      begin
      // Pointer sur les lignes sélectionnées
        GotoBookmark(Pointer(DBGrid.SelectedRows.Items[i]));
     // Ajouter la valeur des champs
        SListe.Add(DataM.AdoTable.Fields[1].AsString+';'+
                   DataM.AdoTable.Fields[2].AsString+';'+
                   DataM.AdoTable.Fields[3].AsString+';'+
                   DataM.AdoTable.Fields[4].AsString+';'+
                   DataM.AdoTable.Fields[5].AsString+';'+
                   DataM.AdoTable.Fields[6].AsString+';'+
                   DataM.AdoTable.Fields[7].AsString+';'+
                   DataM.AdoTable.Fields[8].AsString+';');
      end;
    end;
// Condition = si Save Dialog exécuté alors
   if SD.Execute Then
    SListe.SaveToFile(SD.FileName+'.CSV');
  end;
Except
 // En cas d'éxception ou d'érreur
 On E:Exception Do  MessageDlg('Erreur lors de la création de fichier CSV', mtInformation, [mbOK], 0);
end;
end;

procedure TFournisseurs.otal1Click(Sender: TObject);
var Mtt:Real;
    i:Integer;
begin
Try
// Condition = au moins une ligne sélectionné
  if DBGrid.SelectedRows.Count > 0 then
  begin
    with DBGrid.DataSource.DataSet do
    begin
      for i := 0 to DBGrid.SelectedRows.Count-1 do
      begin
      // Pointer sur les lignes sélectionnées
        GotoBookmark(Pointer(DBGrid.SelectedRows.Items[i]));
      // Calculer le montant des dettes
        Mtt:=Mtt+DataM.ADOTable.Fields[22].AsFloat;
      // Se mettre sur la ligne sélectionnée suivante
        DataM.ADOTable.Next;
       end;
    end;
    // Afficher dans un message le montant globale des dettes
    ShowMessage('Montant : '+FormatFloat('0.00',Mtt));
  end;
Except
// En cas d'érreur ou d'éxception
 On E:Exception Do  MessageDlg('Erreur lors de calcul de total', mtInformation, [mbOK], 0);
end;
end;

procedure TFournisseurs.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var  Dataset:TDataset;
     bitmap : TBitmap;
     fixRect : TRect;
     bmpWidth : integer;
     imgIndex : integer;
begin
// Changer la couleur de font
DBGrid.Font.Color:=clWindowText;
Dataset:= (Sender as TDBGrid).DataSource.DataSet;
   with AlternGrid(Sender) do
    begin
    // Mettre chaque ligne à une couleur différente de la couleur de la ligne suivante
         if (DataSet.RecNo mod 2 = 1 ) then
         Canvas.Brush.Color :=$00FFA8A8//$00EFFEE9
         else
         Canvas.Brush.Color :=clSkyBlue;
      if  DataLink.ActiveRecord = Row-1 then
                               begin
                               Canvas.Font.Color:=clWhite;
                               Canvas.Brush.Color:=clGray;
                               end;                   end;
     DBGrid.DefaultDrawColumnCell(Rect,DataCol,Column, State);

// Créer l'icon bloqué ou autoris
// Bloqué = couleur rouge si non couleur normale
If (DataM.ADOTable.Fields[23].AsBoolean) then
begin
    Dbgrid.Canvas.Font.Color:=ClRed;
    Dbgrid.Canvas.Font.Style:=Dbgrid.Canvas.Font.style +[FsBold];
end;

  Dbgrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  fixRect := Rect;

if Column.Title.Caption = 'Sit' then
  begin
     if (DataM.ADOTable.Fields[23].AsBoolean) then
      imgIndex := 6
 else imgIndex := 5;

    bitmap := TBitmap.Create;
    try
      ImageList.GetBitmap(imgIndex,bitmap);
      bmpWidth := (Rect.Bottom - Rect.Top);
      fixRect.Right := Rect.Left + bmpWidth;
      DBGrid.Canvas.StretchDraw(fixRect,bitmap);
    finally
    // Libérer l'image
      bitmap.Free;
    end;
end;

    fixRect := Rect;
    fixRect.Left := fixRect.Left + bmpWidth;

    // créer une numérotation de lignes

if DataM.AdoTable.RecNo <>0 then
begin
 if Column.Title.Caption = 'N°' then
   DBGrid.Canvas.TextOut(Rect.Left + 2, Rect.Top, IntToStr(DataM.AdoTable.RecNo));
end;
end;

procedure TFournisseurs.BBLockedClick(Sender: TObject);
begin
Try
With DataM.ADOTable Do
begin
// Mettre la table mode edition = modification
   Edit;
// Donner la valeur de chaque champs ici on peux utiliser soit Fields[...] soit FieldsByName(...)
// ici inverser la valeur if True then False et le contraire
   Fields[23].Value:=not Fields[23].AsBoolean;
// Valider l'enregistrement
   Post;
end;
Except
// En cas d'érreur
 On E:Exception Do  MessageDlg('Erreur lors de la modification de la fiche fournisseur !', mtInformation, [mbOK], 0);
end;

end;

procedure TFournisseurs.Propriets1Click(Sender: TObject);
var CBox:TComboBox;
    FBox:TComboBox;
    ETaille:TEdit;
    ClBox:TColorBox;
    TClBox:TColorBox;
    CFBox:TComboBox;
    CETaille:TEdit;
    CColorBox:TColorBox;
    ChBox:TCheckBox;
    Proprietes:TForm;
    i:Integer;
begin
// Créer des zones de texte
 CBox:=TComboBox.Create(Nil);
 TClBox:=TColorBox.Create(Nil);
 FBox:=TComboBox.Create(Nil);
 ETaille:=TEdit.Create(Nil);
 ClBox:=TColorBox.Create(Nil);
 CFBox:=TComboBox.Create(Nil);
 CETaille:=TEdit.Create(Nil);
 CColorBox:=TColorBox.Create(Nil);
 ChBox:=TCheckBox.Create(Nil);
 // Créer la boitte de dialog
 Proprietes := CreateMessageDialog('Spécifiez les proprietés de votre état                                                         '+#13+
                                   'Nom de champ'+#13+#13+#13+
                                   'Titre : '+#13+
                                   'Couleur de texte      Fonts                         Taille         Couleur de fonds'+#13+#13+#13+
                                   'Colonne : '+#13+
                                   'Couleur                   Fonts                         Taille'+#13+
                                    #13+#13, mtInformation,[mbYes, mbCancel]);
// Modifier les propriétés de la boitte de dialog
with Proprietes do
 try
 Caption := 'Proporietés';
 CBox.Parent:=Proprietes;
 CBox.Left:=50;
 CBox.Top:=40;
 CBox.Width:=200;
 for i:=0 To DBGrid.Columns.Count-1 Do
 CBox.Items.Add(DBGrid.Columns.Items[i].FieldName);
 CBox.ItemIndex := 0;
// Modifier les paramètres de chaque composant
// CheckBox
 ChBox.Parent:=Proprietes;
 ChBox.Caption:='Visible';
 ChBox.Left:=250;
 ChBox.Top:=43;
 ChBox.Width:=100;
 ChBox.Checked:=True;
// ColorBox
 ClBox.Parent:=Proprietes;
 ClBox.Left:=50;
 ClBox.Top:=90;
 ClBox.Width:=100;
 ClBox.ItemIndex:=15;
// Text ColorBox
 TClBox.Parent:=Proprietes;
 TClBox.Left:=300;
 TClBox.Top:=90;
 TClBox.Width:=100;
// Fonts box
 FBox.Parent:=Proprietes;
 FBox.Left:=150;
 FBox.Top:=90;
 FBox.Width:=100;
 FBox.Items := getfontlist;
 FBox.Text := 'Tahoma';
// Taille de fonts
 ETaille.Parent:=Proprietes;
 ETaille.Text:='8';
 ETaille.Left:=250;
 ETaille.Top:=90;
 ETaille.Width:=50;
///////////////////:
// ColorBox
 CColorBox.Parent:=Proprietes;
 CColorBox.Left:=50;
 CColorBox.Top:=143;
 CColorBox.Width:=100;
 CColorBox.ItemIndex:=15 ;
// Fonts box
 CFBox.Parent:=Proprietes;
 CFBox.Left:=150;
 CFBox.Top:=143;
 CFBox.Width:=100;
 CFBox.Items := getfontlist;
 CFBox.Text := 'Ms sans Serif';
// Taille de fonts
 CETaille.Parent:=Proprietes;
 CETaille.Text:='8';
 CETaille.Left:=250;
 CETaille.Top:=143;
 CETaille.Width:=50;
///////////////////:

if (ShowModal = ID_YES) then
begin
// Couché = Colonne Visible et contraire
   if ChBox.Checked Then DBGrid.Columns.Items[CBox.ItemIndex].Visible:=True
   Else                  DBGrid.Columns.Items[CBox.ItemIndex].Visible:=False;
// Chanegr le titre
if (CBox.text<>'') then
begin
DBGrid.Columns.Items[CBox.ItemIndex].Title.Font.Color:=ClBox.Selected ;
DBGrid.Columns.Items[CBox.ItemIndex].Title.Font.Name:=FBox.Text;
DBGrid.Columns.Items[CBox.ItemIndex].Title.Font.Size:=StrToInt(ETaille.Text) ;
DBGrid.Columns.Items[CBox.ItemIndex].Title.Color:=TClBox.Selected ;
end;
// Changer la couleur des colonnes
DBGrid.Columns.Items[CBox.ItemIndex].Color:=CColorBox.Selected ;
DBGrid.Font.Name:=CFBox.Text;
DBGrid.Font.Size:=StrToInt(CETaille.Text);
end;

Finally
// Libérer la boitte de dialog
 Proprietes.Free;
end;
end;

procedure TFournisseurs.lchargerlesparamtres1Click(Sender: TObject);
begin
// si le fichier paramètres exist alors
if FileExists(ExtractFilePath(Application.ExeName)+'Para') then
 DBGrid.Columns.LoadFromFile(ExtractFilePath(Application.ExeName)+'Para');
end;

procedure TFournisseurs.Sauvegarderlesparamtres1Click(Sender: TObject);
begin
// Enregistrer les paramètres de notre DBGrid
 DBGrid.Columns.SaveToFile(ExtractFilePath(Application.ExeName)+'Para');
end;

procedure TFournisseurs.Listechamps1Click(Sender: TObject);
var CBox:TCheckBox;
    Proprietes:TForm;
    i:Integer;
    X:Integer;
begin
X:=0;
// Créer des zones de texte
 CBox:=TCheckBox.Create(Nil);

 // Créer la boitte de dialog
 Proprietes := CreateMessageDialog('Spécifiez les proprietés de votre état                                                         '+#13+

                                    #13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13+#13, mtInformation,[mbYes, mbCancel]);
// Modifier les propriétés de la boitte de dialog
with Proprietes do
 try
 for i:=0 To DBGrid.Columns.Count-1 Do
 begin
 // Incrémonter la valeur TOP
 X:=X+20;
 // Créer CheckBox
 CBox:=TCheckBox.Create(Nil);
 // Vérifier si le champs n'est pas vide

 if DBGrid.Columns.Items[i].FieldName <>'' Then
 begin
 CBox.Caption:=DBGrid.Columns.Items[i].Title.Caption ;
// DBGrid.Columns.Items[i].FieldName;
// Déffinir les paramètres
 CBox.Parent:=Proprietes;
 CBox.Left:=50;
 CBox.Top:=X;
 CBox.Width:=200;
 CBox.Checked:=True;
 end;
 end;
// Modifier les paramètres de chaque composant
// CheckBox

if (ShowModal = ID_YES) then
begin
// Couché = Colonne Visible et contraire
for i:=0 To ControlCount-1 Do
begin
// si le composant est un CheckBox
 if Controls[i] Is TCheckBox then
// Mettre la valeur visible selon la propriété de CheckBox correspond 
     DBGrid.Columns.Items[i-2].Visible:=(Controls[i] As TCheckBox).Checked;
end;
end;

Finally
// Libérer la fiche crée
 Proprietes.Free;
end;
end;

end.

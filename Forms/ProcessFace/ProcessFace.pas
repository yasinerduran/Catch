unit ProcessFace;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media,
  FMX.Ani, FMX.Gestures, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.Edit;

type
  TProcessFaceForm = class(TForm)
    MainLayout: TLayout;
    HeaderLayout: TLayout;
    TitleLabel1: TLabel;
    Layout2: TLayout;
    HeaderButton: TButton;
    HorzScrollBox1: THorzScrollBox;
    Column1: TLayout;
    ArticleHeaderLayout: TLayout;
    Layout4: TLayout;
    ItemTitle: TLabel;
    ItemSubTitle: TLabel;
    Column2: TLayout;
    Column3: TLayout;
    Label4: TLabel;
    ProcessFaceStyle: TStyleBook;
    ToolbarHolder: TLayout;
    ToolbarPopup: TPopup;
    ToolBar1: TToolBar;
    ToolbarApplyButton: TButton;
    ToolbarCloseButton: TButton;
    ToolbarAddButton: TButton;
    ToolbarPopupAnimation: TFloatAnimation;
    HorzScrollBox2: THorzScrollBox;
    Layout1: TLayout;
    ListBox1: TListBox;
    MetroListBoxItem6: TMetropolisUIListBoxItem;
    MetroListBoxItem1: TMetropolisUIListBoxItem;
    MetroListBoxItem2: TMetropolisUIListBoxItem;
    Layout3: TLayout;
    Layout8: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Layout9: TLayout;
    Label6: TLabel;
    Edit1: TEdit;
    Layout10: TLayout;
    Label7: TLabel;
    Memo1: TMemo;
    Layout5: TLayout;
    Layout6: TLayout;
    Illustration1: TImageControl;
    Layout7: TLayout;
    Label3: TLabel;
    Label5: TLabel;

    procedure HeaderButtonClick(Sender: TObject);

    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);

    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);

    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    FGestureOrigin: TPointF;
    FGestureInProgress: Boolean;
    { Private declarations }
    procedure ShowToolbar(AShow: Boolean);
  public
    { Public declarations }
  end;

var
  ProcessFaceForm: TProcessFaceForm;

implementation

{$R *.fmx}

procedure TProcessFaceForm.HeaderButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TProcessFaceForm.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  DX, DY : Single;
begin
  if EventInfo.GestureID = igiPan then
  begin
    if (TInteractiveGestureFlag.gfBegin in EventInfo.Flags)
      and ((Sender = ToolbarPopup)
        or (EventInfo.Location.Y > (ClientHeight - 70))) then
    begin
      FGestureOrigin := EventInfo.Location;
      FGestureInProgress := True;
    end;

    if FGestureInProgress and (TInteractiveGestureFlag.gfEnd in EventInfo.Flags) then
    begin
      FGestureInProgress := False;
      DX := EventInfo.Location.X - FGestureOrigin.X;
      DY := EventInfo.Location.Y - FGestureOrigin.Y;
      if (Abs(DY) > Abs(DX)) then
        ShowToolbar(DY < 0);
    end;
  end
end;

//This will be transferred !
procedure TProcessFaceForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    Close;
end;
//This will be transferred !
procedure TProcessFaceForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbRight then
    ShowToolbar(True)
  else
    ShowToolbar(False);
end;
 //This will be transferred !
procedure TProcessFaceForm.ShowToolbar(AShow: Boolean);
begin
  ToolbarPopup.Width := ClientWidth;
  ToolbarPopup.PlacementRectangle.Rect := TRectF.Create(0, ClientHeight-ToolbarPopup.Height, ClientWidth-1, ClientHeight-1);
  ToolbarPopupAnimation.StartValue := ToolbarPopup.Height;
  ToolbarPopupAnimation.StopValue := 0;

  ToolbarPopup.IsOpen := AShow;
end;

end.

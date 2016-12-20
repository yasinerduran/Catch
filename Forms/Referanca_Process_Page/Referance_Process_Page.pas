unit Referance_Process_Page;

interface
 //This will be transferred !
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media,
  FMX.Ani, FMX.Gestures, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TReferanceProcessForm = class(TForm)
    StyleBook2: TStyleBook;
    MainLayout: TLayout;
    HeaderLayout: TLayout;
    TitleLabel1: TLabel;
    HorzScrollBox1: THorzScrollBox;
    Column1: TLayout;
    ArticleHeaderLayout: TLayout;
    Illustration1: TImageControl;
    Layout4: TLayout;
    ItemTitle: TLabel;
    ItemSubTitle: TLabel;
    Label1: TLabel;
    Column2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Column3: TLayout;
    Layout2: TLayout;
    HeaderButton: TButton;
    ToolbarHolder: TLayout;
    ToolbarPopup: TPopup;
    ToolBar1: TToolBar;
    ToolbarApplyButton: TButton;
    ToolbarCloseButton: TButton;
    ToolbarAddButton: TButton;
    ToolbarPopupAnimation: TFloatAnimation;
    Layout1: TLayout;
    Layout3: TLayout;
    Label4: TLabel;
    Layout5: TLayout;
    Layout6: TLayout;
    Label6: TLabel;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Layout9: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    Layout16: TLayout;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Layout17: TLayout;
    Layout18: TLayout;
    Layout19: TLayout;
    Layout20: TLayout;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    Layout12: TLayout;
    Button1: TButton;
    //This will be transferred !
    procedure HeaderButtonClick(Sender: TObject);
      //This will be transferred !
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
      //This will be transferred !
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
      //This will be transferred !
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    FGestureOrigin: TPointF;
    FGestureInProgress: Boolean;
    { Private declarations }
    procedure ShowToolbar(AShow: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReferanceProcessForm: TReferanceProcessForm;

implementation

{$R *.fmx}


//This will be transferred !
procedure TReferanceProcessForm.HeaderButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TReferanceProcessForm.FormGesture(Sender: TObject;
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
procedure TReferanceProcessForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    Close;
end;
//This will be transferred !
procedure TReferanceProcessForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbRight then
    ShowToolbar(True)
  else
    ShowToolbar(False);
end;
 //This will be transferred !
procedure TReferanceProcessForm.ShowToolbar(AShow: Boolean);
begin
  ToolbarPopup.Width := ClientWidth;
  ToolbarPopup.PlacementRectangle.Rect := TRectF.Create(0, ClientHeight-ToolbarPopup.Height, ClientWidth-1, ClientHeight-1);
  ToolbarPopupAnimation.StartValue := ToolbarPopup.Height;
  ToolbarPopupAnimation.StopValue := 0;

  ToolbarPopup.IsOpen := AShow;
end;

end.

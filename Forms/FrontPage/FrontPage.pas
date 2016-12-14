unit FrontPage;

interface

uses
 System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media, FMX.Ani, FMX.Gestures, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFrontPageForm = class(TForm)
    MainLayout: TLayout;
   ToolbarHolder: TLayout;

    HeaderLayout: TLayout;
    TitleLabel1: TLabel;
    HorzScrollBox1: THorzScrollBox;
    GroupLayout1: TLayout;
    ListBox1: TListBox;
    MetroListBoxItem6: TMetropolisUIListBoxItem;
    MetroListBoxItem1: TMetropolisUIListBoxItem;
    MetroListBoxItem2: TMetropolisUIListBoxItem;
    GroupTitle1: TLabel;
    GroupLayout2: TLayout;
    ListBox2: TListBox;
    MetroListBoxItem3: TMetropolisUIListBoxItem;
    MetroListBoxItem4: TMetropolisUIListBoxItem;
    GroupTitle2: TLabel;
    GroupLayout3: TLayout;
    ListBox3: TListBox;
    MetroListBoxItem7: TMetropolisUIListBoxItem;
    MetroListBoxItem8: TMetropolisUIListBoxItem;
    MetroListBoxItem9: TMetropolisUIListBoxItem;
    labelgt3: TLabel;
    Layout1: TLayout;
    ListBox4: TListBox;
    MetropolisUIListBoxItem1: TMetropolisUIListBoxItem;
    MetropolisUIListBoxItem2: TMetropolisUIListBoxItem;
    Label1: TLabel;
    ToolbarPopup: TPopup;
    ToolBar1: TToolBar;
    ToolbarApplyButton: TButton;
    ToolbarCloseButton: TButton;
    ToolbarPopupAnimation: TFloatAnimation;
    Label3: TLabel;
    Label4: TLabel;
   procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure ToolbarCloseButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);

    procedure MetroListBoxItem3Click(Sender: TObject);
    procedure MetropolisUIListBoxItem1Click(Sender: TObject);
    procedure MetroListBoxItem6Click(Sender: TObject);
    procedure ToolbarApplyButtonClick(Sender: TObject);
  private
    FGestureOrigin: TPointF;
    FGestureInProgress: Boolean;
    { Private declarations }
    procedure ShowToolbar(AShow: Boolean);
  public
    { Public declarations }
  end;

var
  FrontPageForm: TFrontPageForm;

implementation
uses Math ,LoginPage;
var
  Form: TCommonCustomForm;
{$R *.fmx}



procedure TFrontPageForm.ToolbarApplyButtonClick(Sender: TObject);
begin
Form := Application.GetDeviceForm('Main');
  if Assigned(Form) then
  Form.Show;
end;

procedure TFrontPageForm.ToolbarCloseButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrontPageForm.FormGesture(Sender: TObject;
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

procedure TFrontPageForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    ShowToolbar(not ToolbarPopup.IsOpen);
end;

procedure TFrontPageForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbRight then
    ShowToolbar(True)
  else
    ShowToolbar(False);
end;

procedure TFrontPageForm.MetroListBoxItem3Click(Sender: TObject);

begin
 {}
end;

procedure TFrontPageForm.MetroListBoxItem6Click(Sender: TObject);
begin
   Form := Application.GetDeviceForm('CreatedProcess');
  if Assigned(Form) then
  Form.Show;
end;

procedure TFrontPageForm.MetropolisUIListBoxItem1Click(Sender: TObject);
begin
   Form := Application.GetDeviceForm('ProcessFace');
  if Assigned(Form) then
  Form.Show;
end;

procedure TFrontPageForm.ShowToolbar(AShow: Boolean);
begin
  ToolbarPopup.Width := ClientWidth;
  ToolbarPopup.PlacementRectangle.Rect := TRectF.Create(0, ClientHeight-ToolbarPopup.Height, ClientWidth-1, ClientHeight-1);
  ToolbarPopupAnimation.StartValue := ToolbarPopup.Height;
  ToolbarPopupAnimation.StopValue := 0;

  ToolbarPopup.IsOpen := AShow;
end;



end.

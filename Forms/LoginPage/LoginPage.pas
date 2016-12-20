unit LoginPage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media, FMX.Ani, FMX.Gestures, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Graphics ;

type
  TLoginPageForm = class(TForm)
    Video: TLayout;
    MediaPlayer1: TMediaPlayer;
    MediaPlayerControl1: TMediaPlayerControl;
    LoginPageStyle: TStyleBook;
    ToolbarHolder: TLayout;
    ToolbarPopup: TPopup;
    ToolbarPopupAnimation: TFloatAnimation;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Label4: TLabel;
    Layout5: TLayout;
    Label6: TLabel;
    Layout6: TLayout;
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

    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure ToolbarCloseButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ItemClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FGestureOrigin: TPointF;
    FGestureInProgress: Boolean;

    { Private declarations }
    procedure ShowToolbar(AShow: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginPageForm: TLoginPageForm;

implementation

uses Math;

{$R *.fmx}



procedure TLoginPageForm.ItemClick(Sender: TObject);
var
  Form: TCommonCustomForm;
begin
  Form := Application.GetDeviceForm('DetailView');
  if Assigned(Form) then
    Form.Show;
end;

procedure TLoginPageForm.Button1Click(Sender: TObject);
var
  Form: TCommonCustomForm;
begin
   Form := Application.GetDeviceForm('FrontPage');
   if Assigned(Form) then
   Form.Show;
   MediaPlayer1.Stop;



  end;


procedure TLoginPageForm.FormActivate(Sender: TObject);
begin
MediaPlayer1.FileName:='Backround.avi'  ;
MediaPlayer1.Play;
end;

procedure TLoginPageForm.FormCreate(Sender: TObject);
begin
VKAutoShowMode := TVKAutoShowMode.Never;

end;

procedure TLoginPageForm.FormGesture(Sender: TObject;
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

procedure TLoginPageForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    ShowToolbar(not ToolbarPopup.IsOpen);
end;

procedure TLoginPageForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbRight then
    ShowToolbar(True)
  else
    ShowToolbar(False);
end;

procedure TLoginPageForm.FormShow(Sender: TObject);
begin
MediaPlayer1.FileName:='Backround.avi';
  MediaPlayer1.Play;
  MediaPlayerControl1.Position.X:=0;
  MediaPlayerControl1.Position.Y:=0;
  MediaPlayerControl1.Width:=Screen.Width;
  MediaPlayerControl1.Height:=Screen.Height;
end;

procedure TLoginPageForm.ShowToolbar(AShow: Boolean);
begin
  ToolbarPopup.Width := ClientWidth;
  ToolbarPopup.PlacementRectangle.Rect := TRectF.Create(0, ClientHeight-ToolbarPopup.Height, ClientWidth-1, ClientHeight-1);
  ToolbarPopupAnimation.StartValue := ToolbarPopup.Height;
  ToolbarPopupAnimation.StopValue := 0;

  ToolbarPopup.IsOpen := AShow;

end;

procedure TLoginPageForm.ToolbarCloseButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

unit CreatedProcess;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media,
  FMX.Ani, FMX.Gestures, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ExtCtrls,
  FMX.TabControl;

type
  TCreatedProcessForm = class(TForm)
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
    CreatedProcessStyle: TStyleBook;
    ToolbarHolder: TLayout;
    ToolbarPopup: TPopup;
    ToolBar1: TToolBar;
    ToolbarCloseButton: TButton;
    ToolbarPopupAnimation: TFloatAnimation;
    ImageViewer1: TImageViewer;
    Layout1: TLayout;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Button2: TButton;
    Panel1: TPanel;
    Layout3: TLayout;
    Layout5: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Layout6: TLayout;
    Layout7: TLayout;
    Label3: TLabel;
    LeftLayout: TLayout;
    ListBoxItems: TListBox;
    ArticleHeader1: TMetropolisUIListBoxItem;
    ArticleHeader2: TMetropolisUIListBoxItem;
    ArticleHeader3: TMetropolisUIListBoxItem;
    ArticleHeader4: TMetropolisUIListBoxItem;
    Layout8: TLayout;
    Label5: TLabel;
    Layout9: TLayout;
    Button3: TButton;
    ToolbarAddButton: TButton;

    procedure HeaderButtonClick(Sender: TObject);

    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);

    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);

    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ToolbarCloseButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    FGestureOrigin: TPointF;
    FGestureInProgress: Boolean;
    { Private declarations }
    procedure ShowToolbar(AShow: Boolean);
  public
    { Public declarations }
  end;

var
  CreatedProcessForm: TCreatedProcessForm;

implementation

{$R *.fmx}

procedure TCreatedProcessForm.HeaderButtonClick(Sender: TObject);
begin
  Close;
end;


procedure TCreatedProcessForm.Button1Click(Sender: TObject);
begin
  TabControl1.Last();
end;

procedure TCreatedProcessForm.Button2Click(Sender: TObject);
begin
  TabControl1.First();
end;

procedure TCreatedProcessForm.FormGesture(Sender: TObject;
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
procedure TCreatedProcessForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    Close;
end;
//This will be transferred !
procedure TCreatedProcessForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbRight then
    ShowToolbar(True)
  else
    ShowToolbar(False);
end;
 //This will be transferred !
procedure TCreatedProcessForm.ShowToolbar(AShow: Boolean);
begin
  ToolbarPopup.Width := ClientWidth;
  ToolbarPopup.PlacementRectangle.Rect := TRectF.Create(0, ClientHeight-ToolbarPopup.Height, ClientWidth-1, ClientHeight-1);
  ToolbarPopupAnimation.StartValue := ToolbarPopup.Height;
  ToolbarPopupAnimation.StopValue := 0;

  ToolbarPopup.IsOpen := AShow;
end;

procedure TCreatedProcessForm.ToolbarCloseButtonClick(Sender: TObject);
begin
  Close;
end;

end.

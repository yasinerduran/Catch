program Project1;

uses
  FMX.Forms,
  LoginPage in '..\Forms\LoginPage\LoginPage.pas' {LoginPageForm},
  Referance_Process_Page in '..\Forms\Referanca_Process_Page\Referance_Process_Page.pas' {ReferanceProcessForm},
  ProcessObject in '..\Forms\ProcessObject\ProcessObject.pas' {ProcessObjectForm},
  FrontPage in '..\Forms\FrontPage\FrontPage.pas' {FrontPageForm},
  ProcessFace in '..\Forms\ProcessFace\ProcessFace.pas' {ProcessFaceForm},
  CreatedProcess in '..\Forms\CreatedProcess\CreatedProcess.pas' {CreatedProcessForm},
  OpenCV in '..\DLL\OpenCV\ControlUnit\OpenCV.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLoginPageForm, LoginPageForm);
  Application.CreateForm(TReferanceProcessForm, ReferanceProcessForm);
  Application.CreateForm(TProcessObjectForm, ProcessObjectForm);
  Application.CreateForm(TFrontPageForm, FrontPageForm);
  Application.CreateForm(TProcessFaceForm, ProcessFaceForm);
  Application.CreateForm(TCreatedProcessForm, CreatedProcessForm);
  Application.RegisterFormFamily('Main', [TLoginPageForm]);
  Application.RegisterFormFamily('DetailView', [TReferanceProcessForm]);
  Application.RegisterFormFamily('ProcessObject', [TProcessObjectForm]);
  Application.RegisterFormFamily('FrontPage', [TFrontPageForm]);
  Application.RegisterFormFamily('CreatedProcess', [TCreatedProcessForm]);
  Application.RegisterFormFamily('ProcessFace', [TProcessFaceForm]);
  Application.Run;
end.

program Project1;

uses
  FMX.Forms,
  Login_Page in '..\Forms\LoginPage\Login_Page.pas' {LoginPageForm},
  Referance_Process_Page in '..\Forms\Referanca_Process_Page\Referance_Process_Page.pas' {ReferanceProcessForm},
  ProcessObject in '..\Forms\ProcessObject\ProcessObject.pas' {ProcessObjectForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLoginPageForm, LoginPageForm);
  Application.CreateForm(TReferanceProcessForm, ReferanceProcessForm);
  Application.CreateForm(TProcessObjectForm, ProcessObjectForm);
  Application.RegisterFormFamily('Main', [TLoginPageForm]);
  Application.RegisterFormFamily('DetailView', [TReferanceProcessForm]);
  Application.RegisterFormFamily('ProcessObject', [TProcessObjectForm]);
  Application.Run;
end.

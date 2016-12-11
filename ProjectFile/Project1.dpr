program Project1;

uses
  FMX.Forms,
  Login_Page in '..\Forms\LoginPage\Login_Page.pas' {LoginPageForm},
  Referance_Process_Page in '..\Forms\Referanca_Process_Page\Referance_Process_Page.pas' {ReferanceProcessForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLoginPageForm, LoginPageForm);
  Application.CreateForm(TReferanceProcessForm, ReferanceProcessForm);
  Application.RegisterFormFamily('Main', [TLoginPageForm]);
  Application.RegisterFormFamily('DetailView', [TReferanceProcessForm]);
  Application.Run;
end.

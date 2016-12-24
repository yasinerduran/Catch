unit OpenCV;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media, FMX.Ani, FMX.Gestures, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Graphics,
  Windows,  Vcl.Controls, Vcl.StdCtrls , FrontPage;
  // Class Tanýmlamasý //

type
Camera = Class
  Public
     // Fonksiyon isimleri dll ile ayný adda oluþturulacak
     function OpenCam(a:Double):Double;
     function GetCamList():Double;
     function CloseCam():Double;
     function NewItem(a:Double):TMetropolisUIListBoxItem;
  Private
  Protected
End;
  // DLL için funksiyon Tanýmý TDLLXxx //
  TDLLOpenCam  =function (a:Double):Double;
  TDLLCloseCam =function ():Double;
  TDLLGetCamList =function ():Double;
implementation
  //Dll içindeki Fonksiyonlarýn Tanýmlanmasý
  const
  DllAdi='OpenCV.dll';//Kullanýlacak dll adý
  // Fonksiyon isimleri dll ile ayný adda oluþturulacak FuncXxxx
  FuncOpenCam    = 'OpenCam';
  FuncCloseCam   = 'CloseCam';
  FuncGetCamList = 'GetCamList';
//-- Class Fonksiyonlar Burada Tanýmlanýyor

  function Camera.OpenCam(a:Double):Double;
   var
    DllHandle:THandle;  //dll fonksiyonu elde edecek deðiþken
    Sonuc:Double;  //iþlem sonucunu tutacak deðiþken
    Address:Pointer;   //dll içindeki fonksiyonun adresi
    _function:TDllOpenCam; //bu deðiþkene ise fonksiyon adresi
    begin
       DllHandle:=LoadLibrary(DllAdi); //Dll i hafýzaya yükle
       if DllHandle=0  then {dll bulunamadý} Result := -1
        else
          try
            Address:=GetProcAddress(DllHandle,FuncOpenCam);  //dll içindeki fonksiyon adresini bul
            if not Assigned(Address) then Result := -2
            else begin
                _function:=TDllOpenCam(Address); //o adresi fonksiyona ata //
                Sonuc := _function(a);
                Result :=sonuc ;
            end;
          except
            on E:Exception do begin  //bir hata oluþursa oluþan hata
            Result := -3;
            end;
          end;
    FreeLibrary(DllHandle);
    end;

// --- //

  function Camera.CloseCam():Double;
   var
    DllHandle:THandle;
    Sonuc:Double;
    Address:Pointer;
    _function:TDllCloseCam;
    begin
       DllHandle:=LoadLibrary(DllAdi);
       if DllHandle=0 then Result := -1
        else
          try
            Address:=GetProcAddress(DllHandle,FuncCloseCam);
            if not Assigned(Address)  then Result := -2
            else begin
                _function:=TDllCloseCam(Address);
                Sonuc := _function();
                Result :=sonuc ;
            end;
          except
            on E:Exception do begin
            Result := -3;
            end;
          end;
    FreeLibrary(DllHandle);
    end;

// --- //


  function Camera.GetCamList():Double;
   var
    DllHandle:THandle;
    Sonuc:Double;
    Address:Pointer;
    _function:TDllGetCamList;
    begin
       DllHandle:=LoadLibrary(DllAdi);
       if DllHandle=0 then Result := -1
        else
          try
            Address:=GetProcAddress(DllHandle,FuncGetCamList);
            if not Assigned(Address)  then Result := -2
            else begin
                _function:=TDllGetCamList(Address);
                Sonuc := _function();
                Result :=sonuc ;
            end;
          except
            on E:Exception do begin
            Result := -3;
            end;
          end;
    FreeLibrary(DllHandle);
    end;

// --- //


  function Camera.NewItem(a: Double):TMetropolisUIListBoxItem;
    var
    item : TMetropolisUIListBoxItem;
    begin
      //item := item.Create();
      //item.Name:=FloatToStr(a);
      //item.Title:='Merhaba';
      //Result:=item;
    end;

// --- //



end.

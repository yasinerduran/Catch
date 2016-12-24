unit OpenCV;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media, FMX.Ani, FMX.Gestures, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Graphics,
  Windows,  Vcl.Controls, Vcl.StdCtrls , FrontPage;
  // Class Tan�mlamas� //

type
Camera = Class
  Public
     // Fonksiyon isimleri dll ile ayn� adda olu�turulacak
     function OpenCam(a:Double):Double;
     function GetCamList():Double;
     function CloseCam():Double;
     function NewItem(a:Double):TMetropolisUIListBoxItem;
  Private
  Protected
End;
  // DLL i�in funksiyon Tan�m� TDLLXxx //
  TDLLOpenCam  =function (a:Double):Double;
  TDLLCloseCam =function ():Double;
  TDLLGetCamList =function ():Double;
implementation
  //Dll i�indeki Fonksiyonlar�n Tan�mlanmas�
  const
  DllAdi='OpenCV.dll';//Kullan�lacak dll ad�
  // Fonksiyon isimleri dll ile ayn� adda olu�turulacak FuncXxxx
  FuncOpenCam    = 'OpenCam';
  FuncCloseCam   = 'CloseCam';
  FuncGetCamList = 'GetCamList';
//-- Class Fonksiyonlar Burada Tan�mlan�yor

  function Camera.OpenCam(a:Double):Double;
   var
    DllHandle:THandle;  //dll fonksiyonu elde edecek de�i�ken
    Sonuc:Double;  //i�lem sonucunu tutacak de�i�ken
    Address:Pointer;   //dll i�indeki fonksiyonun adresi
    _function:TDllOpenCam; //bu de�i�kene ise fonksiyon adresi
    begin
       DllHandle:=LoadLibrary(DllAdi); //Dll i haf�zaya y�kle
       if DllHandle=0  then {dll bulunamad�} Result := -1
        else
          try
            Address:=GetProcAddress(DllHandle,FuncOpenCam);  //dll i�indeki fonksiyon adresini bul
            if not Assigned(Address) then Result := -2
            else begin
                _function:=TDllOpenCam(Address); //o adresi fonksiyona ata //
                Sonuc := _function(a);
                Result :=sonuc ;
            end;
          except
            on E:Exception do begin  //bir hata olu�ursa olu�an hata
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

unit OpenCV;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media, FMX.Ani, FMX.Gestures, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Graphics,
  Windows,  Vcl.Controls, Vcl.StdCtrls;
  // Class Tanýmlamasý //

type
Camera = Class
  Public
     // Fonksiyon isimleri dll ile ayný adda oluþturulacak
     function OpenCam(a:Double):Double;
  Private
  Protected
End;
   // DLL için funksiyon Tanýmý TDLLXxx //
  TDLLOpenCam =function (a:Double):Double;
implementation
   //Dll içindeki Fonksiyonlarýn Tanýmlanmasý
  const
  DllAdi='OpenCV.dll';//Kullanýlacak dll adý
  // Fonksiyon isimleri dll ile ayný adda oluþturulacak FuncXxxx
  FuncOpenCam='OpenCam';
//-- Class Fonksiyonlar Burada Tanýmlanýyor
  function Camera.OpenCam(a: Double):Double;
   var
    DllHandle:THandle;//dll fonksiyonu elde edecek deðiþken
    Sonuc:Double;//iþlem sonucunu tutacak deðiþken
    Address:Pointer;//dll içindeki fonksiyonun adresi
    _function:TDllOpenCam; //bu deðiþkene ise fonksiyon adresi
  begin
     DllHandle:=LoadLibrary(DllAdi);//Dll i hafýzaya yükle
     if DllHandle=0 {dll bulunamadý} then Result := -1
      else
        try
          Address:=GetProcAddress(DllHandle,FuncOpenCam);//dll içindeki fonksiyon adresini bul
          if not Assigned(Address) {dll içindeki adres bulunamadý} then Result := -2
          else begin
              _function:=TDllOpenCam(Address);//o adresi fonksiyona ata //artýk _function deðiþkeni dll içindeki Topla deðiþkenini gösterdiðinden onu her kullandýðýmýzda dll içindeki fonksiyon çalýþacaktýr
              Sonuc := _function(a);//dll fonksiyonu çalýþtýrýlýyor
              Result :=sonuc ;
          end;
        except
          on E:Exception do begin //bir hata oluþursa oluþan hata
          Result := -3;
          end;
        end;
  FreeLibrary(DllHandle);
  end;

// --- //

end.

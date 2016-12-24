unit OpenCV;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Menus, FMX.Media, FMX.Ani, FMX.Gestures, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Graphics,
  Windows,  Vcl.Controls, Vcl.StdCtrls;
// Class Tan�mlamas� //

type
Camera = Class
  Public
     // Fonksiyon isimleri dll ile ayn� adda olu�turulacak
     function OpenCam(a:Double):Double;
  Private
  Protected
End;
  // DLL i�in funksiyon Tan�m� TDLLXxx //
  TDLLOpenCam =function (a:Double):Double;
  // --- //
{$R *.dfm}
implementation
  //Dll i�indeki Fonksiyonlar�n Tan�mlanmas�
  const
  DllAdi='MathLibrary.dll';//Kullan�lacak dll ad�
  // Fonksiyon isimleri dll ile ayn� adda olu�turulacak FuncXxxx
  FuncOpenCam='OpenCam';
//-- Class Fonksiyonlar Burada Tan�mlan�yor
  function Camera.OpenCam(a: Double):Double;
   var
    DllHandle:THandle;//dll fonksiyonu elde edecek de�i�ken
    Sonuc:Double;//i�lem sonucunu tutacak de�i�ken
    Address:Pointer;//dll i�indeki fonksiyonun adresi
    _function:TDllOpenCam; //bu de�i�kene ise fonksiyon adresi
  begin
     DllHandle:=LoadLibrary(DllAdi);//Dll i haf�zaya y�kle
     if DllHandle=0 {dll bulunamad�} then //ShowMessage('Dll Dosyas� Bulunamad�')
      else
        try
          Address:=GetProcAddress(DllHandle,FuncOpenCam);//dll i�indeki fonksiyon adresini bul
          if not Assigned(Address) {dll i�indeki adres bulunamad�} then
             // ShowMessage('Dll ��inde Aranan Fonksiyon Bulunamad� !')
          else begin
              _function:=TDllOpenCam(Address);//o adresi fonksiyona ata //art�k _function de�i�keni dll i�indeki Topla de�i�kenini g�sterdi�inden onu her kulland���m�zda dll i�indeki fonksiyon �al��acakt�r
              Sonuc := _function(a);//dll fonksiyonu �al��t�r�l�yor
          end;
        except
          on E:Exception do begin //bir hata olu�ursa olu�an hata
          //ShowMessage('Fonksiyon i�lenirken HATA!');
          end;
        end;
  FreeLibrary(DllHandle);
  end;

// --- //

end.

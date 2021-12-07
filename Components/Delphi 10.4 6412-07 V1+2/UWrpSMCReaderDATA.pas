(* ----------------------------------------------------------------------------
        SmartCard Reader : Lib for TSMCThaiData
        Create By   : Warapetch Ruangpornvisuthi
        Create Date : 2014-03-30
        CopyRight , All Rights Reserved by Warapetch Ruangpornvisuthi
 ---------------------------------------------------------------------------- *)

unit UWrpSMCReaderDATA;

interface
    uses  System.SysUtils, System.Classes ,
          Vcl.ExtCtrls ; {for TImage}
Type
  TSMCThaiData = record
    Person_CID      ,
    Person_Sex      ,
    Person_TitleTH  ,
    Person_FNameTH  ,
    Person_MiddleTH ,
    Person_LNameTH  ,
    Person_TitleEN  ,
    Person_FNameEN  ,
    Person_MiddleEN ,
    Person_LNameEN  : String;

    Person_Birth : TDateTime;
    Card_SDate   : TDateTime;
    Card_EDate   : TDateTime;
    Person_Religion  : String;
    Card_Barcode     : String; // OFF 6402-19
    Card_RequestNo   : String;
    Card_ChipInfo    : String;
    Card_Creator     : String;
    Card_Storage1    : String;
    Card_Storage2    : String;
    Card_Storage3    : String;

    Address_1        : String;
    Address_2        : String;
    Address_3        : String;
    Address_4        : String;
    Address_5        : String;
    Address_6        : String;
    Address_7        : String;
    Address_8        : String;
    Address_9        : String;
    Addr_TambolName  : String;
    Addr_AmpurName   : String;
    Addr_ChangwatName: String;

    TextForDisplay   : TStringList;
    TextRawData      : String;
    Photo            : TImage;
    PhotoFileName    : String;
  end;

  Type
     TThaiSMCData = Class(TComponent)

     private
        FDatas: TSMCThaiData;
        procedure SetDatas(const Value: TSMCThaiData);
     public
        constructor Create(Acomponent : TComponent); Override;
        destructor  Destroy; Override;

        property Datas : TSMCThaiData read FDatas write SetDatas;
     published
  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Warapetch', [TThaiSMCData]);
end;

{ TThaiSMCData }

constructor TThaiSMCData.Create(Acomponent: TComponent);
begin
   inherited;
   //FDatas.Photo    := TImage.Create(NIL);

end;

destructor TThaiSMCData.Destroy;
begin
   //FreeAndNil(FDatas.Photo);

   inherited;
end;

procedure TThaiSMCData.SetDatas(const Value: TSMCThaiData);
begin
   FDatas := Value;
end;

end.

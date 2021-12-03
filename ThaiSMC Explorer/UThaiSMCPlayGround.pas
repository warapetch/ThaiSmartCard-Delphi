unit UThaiSMCPlayGround;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.ValEdit,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,

  UThaiSMCReaderV2;

type
  TFrmThaiSMCPlayGround = class(TForm)
    PCMain: TPageControl;
    pnlTop: TPanel;
    TabReadMan_Value: TTabSheet;
    TabReadMan_PlayGround: TTabSheet;
    TabReadMan_Photo: TTabSheet;
    btnGetPhoto: TBitBtn;
    vleAPDU1: TValueListEditor;
    btnGetText: TBitBtn;
    mmDatas: TMemo;
    mmData1: TMemo;
    pnlPG_Top: TPanel;
    cbbAPDU: TComboBox;
    btnTest: TBitBtn;
    vleAPDU_Image: TValueListEditor;
    lblCapAPDU: TLabel;
    imgPersonMan: TImage;
    bvImage: TBevel;
    TabReadAuto: TTabSheet;
    imgPersonAuto: TImage;
    bvImage2: TBevel;
    btnReadCard: TBitBtn;
    lblCapHeader: TLabel;
    lblCapWarapetch: TLabel;
    lblCapSubHeader: TLabel;
    TabAbout: TTabSheet;
    btnConnectDriver: TBitBtn;
    btnDisConnectDriver: TBitBtn;
    pnlDeviceStatus: TPanel;
    imgWarapetch: TImage;
    Label1: TLabel;
    btnClearValues: TBitBtn;
    pbGetPhoto: TProgressBar;
    pnlToolbar: TPanel;
    lblDriverName: TLabel;
    lblATR: TLabel;
    pnlCardStatus: TPanel;
    Panel1: TPanel;
    mmStatus: TMemo;
    PCReadAuto: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mmDataAuto: TMemo;
    vleDataAuto: TValueListEditor;
    ThaiSMCReaderV21: TThaiSMCReaderV2;
    cbxAutoReadCard: TCheckBox;
    cbxEncodingThai874: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnGetPhotoClick(Sender: TObject);
    procedure btnReadCardClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnGetTextClick(Sender: TObject);
    procedure btnDisConnectDriverClick(Sender: TObject);
    procedure btnConnectDriverClick(Sender: TObject);
    procedure btnClearValuesClick(Sender: TObject);
    procedure ThaiSMCReaderV21GetPhotoFinish(Sender: TObject; Success: Boolean; Photo: TPicture);
    procedure ThaiSMCReaderV21GetValueFinish(Sender: TObject; Success: Boolean; Values: TStringList);
    procedure ThaiSMCReaderV21StatusChange(Sender: TObject; Status: string);
    procedure ThaiSMCReaderV21GetPhotoProgress(Sender: TObject; PartTotal, PartComplete: Integer);
    procedure ThaiSMCReaderV21CardResultValue(Sender: TObject; KeyValue: string; var Title, ResultValue: string);
    procedure ThaiSMCReaderV21DriverUpdate(Sender: TObject; Drivers: TStringList);
    procedure ThaiSMCReaderV21CardStateChange(Sender: TObject; CardState: TWrpCardState; CardStateDesc,
      ReaderName: string);
    procedure cbxAutoReadCardClick(Sender: TObject);
    procedure cbxEncodingThai874Click(Sender: TObject);
    procedure ThaiSMCReaderV21DriverConnected(Sender: TObject);
    procedure ThaiSMCReaderV21DriverDisconnect(Sender: TObject);
    procedure ThaiSMCReaderV21BeforeGetValue(Sender: TObject);
    procedure ThaiSMCReaderV21CardInsert(Sender: TObject; ReaderName: string);
    procedure ThaiSMCReaderV21CardRemove(Sender: TObject; ReaderName: string);
    procedure ThaiSMCReaderV21GetValueError(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmThaiSMCPlayGround: TFrmThaiSMCPlayGround;

implementation

{$R *.dfm}

procedure TFrmThaiSMCPlayGround.btnClearValuesClick(Sender: TObject);
begin
    mmDataAuto.Clear;
    vleDataAuto.Strings.Clear;
    imgPersonAuto.Picture := NIL;
end;

procedure TFrmThaiSMCPlayGround.btnConnectDriverClick(Sender: TObject);
begin
    ThaiSMCReaderV21.Open;
end;

procedure TFrmThaiSMCPlayGround.btnDisConnectDriverClick(Sender: TObject);
begin
    ThaiSMCReaderV21.Close;
end;

procedure TFrmThaiSMCPlayGround.btnGetPhotoClick(Sender: TObject);
var FileName : String;
    ADPUarr : TStringlist;
    I : Integer;
begin
    imgPersonMan.Picture := NIL;
    ADPUarr := TStringlist.Create;
    for I := 0 to vleAPDU_Image.Strings.Count-1 do
        //sCaption := vleAPDU_Image.Keys[I+1];
        ADPUarr.Add( vleAPDU_Image.Values[IntTostr(I+1)] );

    ThaiSMCReaderV21.ManualGetPhotoByAPDUs(ADPUarr);
    FreeAndNil(ADPUarr);
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21BeforeGetValue(Sender: TObject);
begin
    mmDataAuto.Clear;
    mmDatas.Clear;
    vleDataAuto.Strings.Clear;
    imgPersonAuto.Picture := NIL;
    imgPersonMan.Picture  := NIL;
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21CardInsert(Sender: TObject; ReaderName: string);
begin
//    mmStatus.Lines.Add('@Event CardInsert >> '+ReaderName+' : บัตรถูกเสียบ ');
    pnlCardStatus.Color := clLime;

    lblDriverName.Caption := ThaiSMCReaderV21.CardReader.ReaderName;
    lblATR.Caption        := ThaiSMCReaderV21.CardReader.ATRasString;

end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21CardRemove(Sender: TObject; ReaderName: string);
begin
//    mmStatus.Lines.Add('@Event CardRemove >> '+ReaderName+' : บัตรถูกถอด / ไม่พบบัตร   ');
    pnlCardStatus.Color := clRed;
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21CardResultValue(Sender: TObject;
    KeyValue: string;
    var Title,ResultValue: string);
begin
    // Convert YMD to DMY
    if (KeyValue = 'birth_date') or
       (KeyValue = 'start_date') or
       (KeyValue = 'expire_date') then
       begin
          // 25641202 >> 02/12/2564
          ResultValue := ThaiSMCReaderV21.CNV_StrYMDToDMY(ResultValue);
       end
    else
    if (KeyValue = 'gender') then
        ResultValue := ThaiSMCReaderV21.CNV_StrToGender(ResultValue)
    else
    if (KeyValue = 'religion') then
        ResultValue := ThaiSMCReaderV21.CNV_StrToReligion(ResultValue);


    // Remove Separate from Value
    if (POS('#',ResultValue) > 0) then
       ResultValue := ThaiSMCReaderV21.StrReplace(ResultValue);


    // Change Title
    if (KeyValue = 'cid') then
        Title := 'เลขบัตร ปชช.'
    else
    if (KeyValue = 'full_name_th') then
        Title := 'ชื่อ นามสกุล (TH)'
    else
    if (KeyValue = 'full_name_en') then
        Title := 'ชื่อ นามสกุล (EN)'
    else
    if (KeyValue = 'birth_date') then
        Title := 'วันเกิด'
    else
    if (KeyValue = 'gender') then
        Title := 'เพศ'
    else
    if (KeyValue = 'office_name') then
        Title := 'ออกโดย'
    else
    if (KeyValue = 'card_start_date') then
        Title := 'วันที่ออกบัตร'
    else
    if (KeyValue = 'card_expire_date') then
        Title := 'บัตรหมดอายุ'
    else
    if (KeyValue = 'religion') then
        Title := 'ศาสนา'
    else
    if (KeyValue = 'address') then
        Title := 'ที่อยู่'
    else
    if (KeyValue = 'under_photo') then
        Title := 'เลขหลังบัตร';

end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21CardStateChange(Sender: TObject;
    CardState: TWrpCardState;
  CardStateDesc, ReaderName: string);
begin
//    mmStatus.Lines.Add('@Event CardStateChange >> '+ReaderName+' : '+CardStateDesc);
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21DriverConnected(Sender: TObject);
begin
    pnlDeviceStatus.Color := clLime;
//    mmStatus.Lines.Add('@Event DeviceConnected >> ติดต่อเครื่องอ่านบัตรประชาชน .. [สำเร็จ]');

    //ThaiSMCReaderV21.DriverConnected;

    btnConnectDriver.Enabled    := False;
    btnDisConnectDriver.Enabled := True;
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21DriverDisconnect(Sender: TObject);
begin
    pnlDeviceStatus.Color := clRed;
//    mmStatus.Lines.Add('@Event DeviceDisconnect >> Device DisConnected !!');

    btnConnectDriver.Enabled    := True;
    btnDisConnectDriver.Enabled := False;
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21DriverUpdate(Sender: TObject;
Drivers: TStringList);
begin
//    mmStatus.Lines.Add('@Event DriverUpdate >> Driver Update ');
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21GetPhotoFinish(Sender: TObject;
Success: Boolean;
Photo: TPicture);
begin
    if Success then
       begin
            Case PCMain.ActivePageIndex of
               0 {TabReadAuto}      : imgPersonAuto.Picture.Assign( Photo );
               2 {TabReadMan_Photo} : imgPersonMan.Picture.Assign( Photo );
            End;
       end;
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21GetPhotoProgress(Sender: TObject;
 PartTotal, PartComplete: Integer);
begin
    pbGetPhoto.Max := PartTotal;

    pbGetPhoto.Position := PartComplete;
    pbGetPhoto.Update;

//    mmStatus.Lines.Add('@Event >> Get Photo ['+ IntToStr(PartComplete)+'/'+IntToStr(PartTotal)+']');

    if (pbGetPhoto.Position = PartTotal) then
        pbGetPhoto.visible := False;
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21GetValueError(Sender: TObject);
begin
    mmStatus.Lines.Add('@Event >> GetValue Error !!');
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21GetValueFinish(Sender: TObject; Success: Boolean; Values: TStringList);
begin
    if Success then
       begin
            Case PCMain.ActivePageIndex of
               0 {TabReadAuto} : mmDataAuto.Text := Values.Text;
               1 {TabReadMan_Value} : mmDatas.Text    := Values.Text;
               3 {TabReadMan_PlayGround} : mmData1.Text    := Values.Text;
            End;

            vleDataAuto.Strings.Text := ThaiSMCReaderV21.DATA.ValueList.Text;
       end;
end;

procedure TFrmThaiSMCPlayGround.ThaiSMCReaderV21StatusChange(Sender: TObject; Status: string);
begin
    mmStatus.Lines.Add(Status);
end;

procedure TFrmThaiSMCPlayGround.btnGetTextClick(Sender: TObject);
var I : Integer;
    tmpSTL : TStringList;
begin

    tmpSTL := TStringList.Create;
    for I := 0 to vleAPDU1.Strings.Count-1 do
        tmpSTL.add(vleAPDU1.Strings[I]);

    ThaiSMCReaderV21.ManualGetValueByAPDUs(tmpSTL);
    FreeAndNil(tmpSTL);
end;

procedure TFrmThaiSMCPlayGround.btnReadCardClick(Sender: TObject);
begin
    ThaiSMCReaderV21.Option.AutoReadCard := True; // Force
    ThaiSMCReaderV21.ReadCard;
end;

procedure TFrmThaiSMCPlayGround.btnTestClick(Sender: TObject);
var rawData : String;
    sCaption ,sADPU : String;
begin
    mmData1.Clear;
    rawData  := cbbAPDU.text;
    sCaption := Copy(rawData,1,POS('=',rawData)-1);
    sADPU    := Trim(Copy(rawData,POS('=',rawData)+1,255));
    rawData  := ThaiSMCReaderV21.ManualGetValueByAPDU(sCaption,sADPU);
    mmData1.Lines.Add(rawData);
end;

procedure TFrmThaiSMCPlayGround.cbxAutoReadCardClick(Sender: TObject);
begin
    ThaiSMCReaderV21.Option.AutoReadCard := cbxAutoReadCard.Checked;
end;

procedure TFrmThaiSMCPlayGround.cbxEncodingThai874Click(Sender: TObject);
begin
    ThaiSMCReaderV21.Option.EncodingThai874 := cbxEncodingThai874.Checked;
end;

procedure TFrmThaiSMCPlayGround.FormShow(Sender: TObject);
begin
    ThaiSMCReaderV21.Open;
end;

end.

{
//-----------------------------------------------
// ThaiSMC Component Version 2
//-----------------------------------------------
#Driver-Connect
	>DriverConnected
		#CardReader-Connect
			>CardInsert

				#ReadCard
				|-- SendAPDU (Select)
				|	|
				|	|-- Mode=AutoRead
				|	|	|-- APDU_Value
				|	|	|-- if Scan Photo
				|	|		   |-- APDU_Photo
				|	|
				|	|-- Mode=Manual
					|	|-- APDU_Manual

			>CardRemove

	>DriverDisConnected
//-----------------------------------------------
}

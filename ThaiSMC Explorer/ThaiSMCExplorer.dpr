program ThaiSMCExplorer;

uses
  Vcl.Forms,
  UThaiSMCPlayGround in 'UThaiSMCPlayGround.pas' {FrmThaiSMCPlayGround},
  UThaiSMCReaderV2 in '..\UThaiSMCReaderV2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TFrmThaiSMCPlayGround, FrmThaiSMCPlayGround);
  Application.Run;
end.

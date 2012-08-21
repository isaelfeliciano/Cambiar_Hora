{En este proyecto se usa un archivo .bat para ejecutar los comandos CMD
para cambiar la hora y fecha de windows.
R13productions®}


unit UAct_Hora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, StdCtrls, DBCtrls, DB, DBClient, SimpleDS, SqlExpr, ShellApi;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    SimpleDataSet1: TSimpleDataSet;
    DBText1: TDBText;
    DataSource1: TDataSource;
    Bt1: TButton;
    Label1: TLabel;
    Bt2: TButton;
    DBText2: TDBText;
    Label2: TLabel;
    procedure Bt1Click(Sender: TObject);
    procedure Bt2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    procedure CrearArchivoBat(rutArchivo: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  cHora, FormatoHora, cFecha :String;
implementation

{$R *.dfm}

procedure TForm1.Bt1Click(Sender: TObject);
begin
Label1.Caption:= FormatDateTime('hh:mm:ss am/pm', now);
if Label1.Caption <> DBText1.Caption then
begin
cFecha:= DBText2.Caption;
Label1.Caption:= DBText1.Caption;
cHora:= Label1.Caption;
SetLength(cHora, 8);
FormatoHora:= Label1.Caption;
Delete(FormatoHora, 1, 8);
if FormatoHora = ' p.m.' then
cHora:= cHora + ' pm'
else
cHora:=cHora + ' am';


end;
end;

procedure TForm1.CrearArchivoBat(rutArchivo: string);
 var
   temp: TStrings;
 begin
   temp := TStringList.Create;
   try
     temp.Add('@echo off');
     temp.Add('time ' + cHora);
     temp.Add('date ' + cFecha);
     temp.SaveToFile(rutArchivo);
   finally
     temp.Free;
   end;
 end;

procedure TForm1.Bt2Click(Sender: TObject);
begin
CrearArchivoBat('D:\archivo.bat');
shellexecute(Handle, 'open','D:\archivo.bat',nil,nil,SW_HIDE);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
SimpleDataSet1.Open;
SimpleDataSet1.Connection:= SQLConnection1;
Bt1.Click;
Bt2.Click;
SimpleDataSet1.Close;
Form1.Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ShowMessage('La fecha y hora han sido actualizadas con el servidor'
+ cHora + ' ' + cFecha)
end;

end.

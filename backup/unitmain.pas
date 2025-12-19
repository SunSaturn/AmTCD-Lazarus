unit unitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  StdCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    Memo2: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Separator2: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure Separator1Click(Sender: TObject);
  private

  public
       function Code(S:WideString; Key: Integer):WideString;
  end;

var
  FormMain: TFormMain;

implementation

uses unitAbout, IniFiles, LazUTF8;

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin

end;

procedure TFormMain.Memo1Change(Sender: TObject);
begin

end;

procedure TFormMain.MenuItem12Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItem3Click(Sender: TObject);
var FileName, S, SS:WideString; F:TIniFile; Key:Integer;
begin
    if OpenDialog1.Execute then begin
         FileName:=OpenDialog1.FileName;
         //Key:=99;
         Memo2.Lines.LoadFromFile(FileName);
         S:=Memo2.Text;
         F:=TIniFile.Create(FileName);
         SS:=Code(F.ReadString('main','Text', S), F.ReadInteger('main','Key', Key));
         Memo1.Lines.Append(SS);
         F.Free;
    end;
end;

procedure TFormMain.MenuItem5Click(Sender: TObject);
var
  FileName, S, SS:WideString;
  Key:Integer;
  F: TIniFile;
begin
  if SaveDialog1.Execute then begin
     FileName:=SaveDialog1.FileName;
     Memo1.Lines.SaveToFile(FileName);
     S:=Memo1.Text;
     Key:=99;
     SS:=Code(S, 99);
     F:=TIniFile.Create(FileName);
     F.WriteInteger('main','Key', Key);
     F.WriteString('main','Text', SS);
     //Key:=F.ReadInteger();
     //SS:=F.ReadString();
     F.Free;
     //Memo2.Text:=SS;
     //Memo2.Lines.SaveToFile(FileName);
  end;
end;

procedure TFormMain.Separator1Click(Sender: TObject);
begin

end;

function TFormMain.Code(S: WideString; Key: Integer): WideString;
var ss, S_:WideString;  C:WideChar; i,K:Integer;
begin
  ss:=' ';
  for i:=1 to Length(S) do begin
    C:=S[i];
    K:=Ord(C);
    K:=K xor Key;
    S_:=UnicodeToUTF8(K);
    ss:=ss+S_;
  end;
  Result:=ss;
end;

end.


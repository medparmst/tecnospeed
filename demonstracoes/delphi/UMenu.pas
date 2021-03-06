unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMenu = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses UeSocialS1, uESocial;

{$R *.dfm}

procedure TfrmMenu.Button2Click(Sender: TObject);
begin
  frmeSocialS1.show;
end;

procedure TfrmMenu.Button1Click(Sender: TObject);
begin
  frmeSocial.show;
end;

end.

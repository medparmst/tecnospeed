unit eSocial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, StdCtrls;

type
  TExemplo = class(TForm)
    btnConfigurar: TButton;
    btnGerarXML: TButton;
    btnAssinar: TButton;
    btnEnviar: TButton;
    btnConsultar: TButton;
    cbbCertificados: TComboBox;
    edtIDLote: TEdit;
    mmXML: TMemo;
    btnIncluir: TButton;
    btnExcluir: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Exemplo: TExemplo;

implementation

{$R *.dfm}

end.
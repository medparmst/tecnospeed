unit UeSocial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  ESocialClientX_TLB, Vcl.ComCtrls;

type
  TfrmeSocial = class(TForm)
    edtCnpjSH: TLabeledEdit;
    edtTokenSH: TLabeledEdit;
    cbAmbiente: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbVersaoManual: TComboBox;
    edtCnpjTransmissor: TLabeledEdit;
    edtCnpjEmpregador: TLabeledEdit;
    Label3: TLabel;
    cbCertificado: TComboBox;
    edtTemplates: TLabeledEdit;
    edtEsquemas: TLabeledEdit;
    btnConfigurar: TButton;
    btnTx2: TButton;
    btnXML: TButton;
    btnAssinar: TButton;
    btnEnviar: TButton;
    btnConsultar: TButton;
    edtIdLote: TLabeledEdit;
    cbGrupo: TComboBox;
    lbl1: TLabel;
    rg: TRadioGroup;
    pgc1: TPageControl;
    tsRetorno: TTabSheet;
    tsXmlEnvio: TTabSheet;
    tsXmlRetorno: TTabSheet;
    mmoRetorno: TMemo;
    mmoXmlEnvio: TMemo;
    mmoXmlRetorno: TMemo;
    txtPincode: TEdit;
    Button1: TButton;
    Label4: TLabel;
    edtIdEvento: TLabeledEdit;
    btnConsultarIdsEventoLote: TButton;
    btnBaixarXMLEvento: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnTx2Click(Sender: TObject);
    procedure btnXMLClick(Sender: TObject);
    procedure btnAssinarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnConsultarIdsEventoLoteClick(Sender: TObject);
    procedure btnBaixarXMLEventoClick(Sender: TObject);
  private
    { Private declarations }
  public
    eSocial: TspdESocialClientX;
    { Public declarations }
  end;

var
  frmeSocial: TfrmeSocial;

implementation

{$R *.dfm}

procedure TfrmeSocial.btnAssinarClick(Sender: TObject);
begin
  mmoRetorno.Text := eSocial.AssinarEvento(mmoRetorno.Text);
end;

procedure TfrmeSocial.btnBaixarXMLEventoClick(Sender: TObject);
var
  RetBaixarXmlEventoLote: IspdRetBaixarXmlEventoLote;
begin
  if (edtIdLote.Text = '') or (edtIdEvento.Text = '') then
    ShowMessage('Por favor preencher o identificador do lote e do evento.');

  RetBaixarXmlEventoLote := eSocial.BaixarXmlEventoLote(edtIdLote.Text, edtIdEvento.Text);

  mmoRetorno.Lines.Clear;
  mmoRetorno.Lines.Add('### BAIXA XML EVENTO LOTE ###');
  mmoRetorno.Lines.Add('Mensagem de Retorno: ' + RetBaixarXmlEventoLote.Mensagem);
  mmoRetorno.Lines.Add('XML Evento: ' + RetBaixarXmlEventoLote.XmlEvento);
end;

procedure TfrmeSocial.btnConfigurarClick(Sender: TObject);
begin
  eSocial.VersaoManual := cbVersaoManual.Text;
  eSocial.NomeCertificado := cbCertificado.Text;
  if txtPincode.Text <> '' then
    begin
    eSocial.TipoCertificado := ckSmartCard;
    eSocial.Pincode := txtPinCode.Text;

    end
   else
    begin
    eSocial.Pincode := '';
    eSocial.TipoCertificado := ckLocalMachine;
    end;
  // eSocial.CaminhoCertificado := 'Caminho do Certificado' Utilizado para passar o Caminho do .pfx do certificado.
  // eSocial.SenhaCertificado := 'Senha do certificado' Utilizado caso o Caminho Certificado seja preenchido.
  // eSocial.Pincode := 'Senha do certificado A3'; Senha do certificado A3 quando utilizado.
  // eSocial.ProxyServidor := 'Servidor com porta';  Utilizado quando existe proxy na rede a ser utilizada
  // eSocial.ProxyUsuario := 'Usuario do Proxy'; Utilizado quando existe proxy na rede a ser utilizada
  // eSocial.ProxySenha := 'Senha do Proxy';  Utilizado quando existe proxy na rede a ser utilizada
  eSocial.DiretorioTemplates := edtTemplates.Text;
  eSocial.DiretorioEsquemas := edtEsquemas.Text;
  eSocial.ConfigurarSoftwareHouse(edtCnpjSH.Text, edtTokenSH.Text);
  eSocial.CpfCnpjTransmissor := edtCnpjTransmissor.Text;
  eSocial.CpfCnpjEmpregador := edtCnpjEmpregador.Text;
  if cbAmbiente.Text = '1 - Produ��o' then
    eSocial.Ambiente := akProducao;
  if cbAmbiente.Text = '2 - Homologa��o' then
    eSocial.Ambiente := akPreProducaoReais;
end;

procedure TfrmeSocial.btnConsultarClick(Sender: TObject);
var
  RetConsulta: IspdRetConsultarLote;
  RetConsultaItem: IspdRetConsultarLoteItem;
  RetConsultaOcorrencia: IspdRetConsultarLoteOcorrencia;
  RetConsultaOcorrenciaEnvio: IspdRetConsultarLoteOcorrenciaEnvio;
  _i, _j, _k, _a, _b, _c, _d, _e, _f: integer;
begin
  if rg.ItemIndex = 0 then
    RetConsulta := eSocial.ConsultarLoteEventos(edtIdLote.Text)
  else if rg.ItemIndex = 1 then
    RetConsulta := eSocial.ConsultarIdEvento(edtIdLote.Text)
  else if rg.ItemIndex = 2 then
    RetConsulta := eSocial.ConsultarEventoPorRecibo(edtIdLote.Text);

  mmoRetorno.Lines.Clear;
  mmoRetorno.Lines.Add('### CONSULTA PROTOCOLO ###');
  mmoRetorno.Lines.Add('N�mero do Protocolo: ' + RetConsulta.NumeroProtocolo);
  mmoRetorno.Lines.Add('Mensagem de Retorno: ' + RetConsulta.Mensagem);
  mmoRetorno.Lines.Add('Status do Lote: ' + RetConsulta.Status);
  mmoRetorno.Lines.Add('Tempo estimado para conclus�o do processamento: ' +
    RetConsulta.TempoEstimadoConclusao);
  mmoRetorno.Lines.Add('Id do Lote: ' + RetConsulta.IdLote);
  for _i := 0 to RetConsulta.Count - 1 do
  begin
    RetConsultaItem := RetConsulta.Eventos[_i];
    mmoRetorno.Lines.Add('    Evento: ' + IntToStr(_i + 1));
    mmoRetorno.Lines.Add('    Id Evento: ' + RetConsultaItem.IdEvento);
    mmoRetorno.Lines.Add('    N�mero Recibo: ' + RetConsultaItem.NumeroRecibo);
    mmoRetorno.Lines.Add('    C�digo de Status: ' + RetConsultaItem.cStat);
    mmoRetorno.Lines.Add('    Mensagem: ' + RetConsultaItem.Mensagem);
    mmoRetorno.Lines.Add('    Status do Evento: ' + RetConsultaItem.Status);
    if not RetConsultaItem.S5001.IsEmpty then
    begin
      mmoRetorno.Lines.Add('        ### S5001 ###');
      mmoRetorno.Lines.Add('        Id: ' + RetConsultaItem.S5001.Id);
      // IdeEvento
      mmoRetorno.Lines.Add('        nrRecArqBase: ' +
        RetConsultaItem.S5001.IdeEvento.NrRecArqBase);
      mmoRetorno.Lines.Add('        indApuracao: ' +
        RetConsultaItem.S5001.IdeEvento.indApuracao);
      mmoRetorno.Lines.Add('        perApur: ' +
        RetConsultaItem.S5001.IdeEvento.perApur);
      // IdeEmpregador
      mmoRetorno.Lines.Add('        tpInsc: ' +
        RetConsultaItem.S5001.IdeEmpregador.tpInsc);
      mmoRetorno.Lines.Add('        nrInsc: ' +
        RetConsultaItem.S5001.IdeEmpregador.nrInsc);
      // IdeTrabalhador
      mmoRetorno.Lines.Add('        cpfTrab: ' +
        RetConsultaItem.S5001.IdeTrabalhador.cpfTrab);
      // ProcJudTrab
      for _a := 0 to RetConsultaItem.S5001.IdeTrabalhador.
        CountProcJudTrab - 1 do
      begin
        mmoRetorno.Lines.Add('        NrProcJud: ' +
          RetConsultaItem.S5001.IdeTrabalhador.ProcJudTrab[_a].NrProcJud);
        mmoRetorno.Lines.Add('        codSusp: ' +
          RetConsultaItem.S5001.IdeTrabalhador.ProcJudTrab[_a].codSusp);
      end;
      // InfoCpCalc
      for _a := 0 to RetConsultaItem.S5001.CountInfoCpCalc - 1 do
      begin
        mmoRetorno.Lines.Add('        tpCR: ' + RetConsultaItem.S5001.InfoCpCalc
          [_a].tpCR);
        mmoRetorno.Lines.Add('        vrCpSeg: ' +
          RetConsultaItem.S5001.InfoCpCalc[_a].vrCpSeg);
        mmoRetorno.Lines.Add('        vrDescSeg: ' +
          RetConsultaItem.S5001.InfoCpCalc[_a].vrDescSeg);
      end;
      // IdeEstabLot
      for _a := 0 to RetConsultaItem.S5001.InfoCp.CountIdeEstabLot - 1 do
      begin
        mmoRetorno.Lines.Add('        vrDescSeg: ' +
          RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].tpInsc);
        mmoRetorno.Lines.Add('        nrInsc: ' +
          RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].nrInsc);
        mmoRetorno.Lines.Add('        codLotacao: ' +
          RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].codLotacao);
        // InfoCategIncid
        for _b := 0 to RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a]
          .CountInfoCategIncid - 1 do
        begin
          mmoRetorno.Lines.Add('        vrDescSeg: ' +
            RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
            .Matricula);
          mmoRetorno.Lines.Add('        codCateg: ' +
            RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
            .codCateg);
          mmoRetorno.Lines.Add('        indSimples: ' +
            RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
            .indSimples);
          // InfoBaseCS
          for _c := 0 to RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a]
            .InfoCategIncid[_b].CountInfoBaseCS - 1 do
          begin
            mmoRetorno.Lines.Add('        Ind13: ' +
              RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
              .InfoBaseCS[_c].Ind13);
            mmoRetorno.Lines.Add('        tpValor: ' +
              RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
              .InfoBaseCS[_c].tpValor);
            mmoRetorno.Lines.Add('        valor: ' +
              RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
              .InfoBaseCS[_c].valor);
          end;
          // CalcTerc
          for _c := 0 to RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a]
            .InfoCategIncid[_b].CountCalcTerc - 1 do
          begin
            mmoRetorno.Lines.Add('        tpCR: ' +
              RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
              .CalcTerc[_c].tpCR);
            mmoRetorno.Lines.Add('        vrCsSegTerc: ' +
              RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
              .CalcTerc[_c].vrCsSegTerc);
            mmoRetorno.Lines.Add('        vrDescTerc: ' +
              RetConsultaItem.S5001.InfoCp.IdeEstabLot[_a].InfoCategIncid[_b]
              .CalcTerc[_c].vrDescTerc);
          end;
        end;
      end;
    end;
    if not RetConsultaItem.S5002.IsEmpty then
    begin
      mmoRetorno.Lines.Add('        ### S5002 ###');
      mmoRetorno.Lines.Add('        Id: ' + RetConsultaItem.S5002.Id);
      // IdeEvento
      mmoRetorno.Lines.Add('        nrRecArqBase: ' +
        RetConsultaItem.S5002.IdeEvento.NrRecArqBase);
      mmoRetorno.Lines.Add('        perApur: ' +
        RetConsultaItem.S5002.IdeEvento.perApur);

      // IdeEmpregador
      mmoRetorno.Lines.Add('        tpInsc: ' +
        RetConsultaItem.S5002.IdeEmpregador.tpInsc);
      mmoRetorno.Lines.Add('        nrInsc: ' +
        RetConsultaItem.S5002.IdeEmpregador.nrInsc);

      // IdeTrabalhador
      mmoRetorno.Lines.Add('        cpfTrab: ' +
        RetConsultaItem.S5002.IdeTrabalhador.cpfTrab);
      // InfoDep
      mmoRetorno.Lines.Add('        vrDedDep: ' +
        RetConsultaItem.S5002.InfoDep.vrDedDep);
      // InfoIrrf
      for _a := 0 to RetConsultaItem.S5002.CountInfoIrrf - 1 do
      begin
        mmoRetorno.Lines.Add('        codCateg: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].codCateg);
        mmoRetorno.Lines.Add('        indResBr: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].indResBr);
        // BasesIrrf
        for _b := 0 to RetConsultaItem.S5002.InfoIrrf[_a].CountBasesIrrf - 1 do
        begin
          mmoRetorno.Lines.Add('        tpValor: ' +
            RetConsultaItem.S5002.InfoIrrf[_a].BasesIrrf[_b].tpValor);
          mmoRetorno.Lines.Add('        Valor: ' +
            RetConsultaItem.S5002.InfoIrrf[_a].BasesIrrf[_b].valor);
        end;
        // Irrf
        for _b := 0 to RetConsultaItem.S5002.InfoIrrf[_a].CountIrrf - 1 do
        begin
          mmoRetorno.Lines.Add('        tpCR: ' + RetConsultaItem.S5002.InfoIrrf
            [_a].Irrf[_b].tpCR);
          mmoRetorno.Lines.Add('        vrIrrfDesc: ' +
            RetConsultaItem.S5002.InfoIrrf[_a].Irrf[_b].vrIrrfDesc);
        end;
        // IdePais
        mmoRetorno.Lines.Add('        codPais: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].IdePgtoExt.IdePais.codPais);
        mmoRetorno.Lines.Add('        indNIF: ' + RetConsultaItem.S5002.InfoIrrf
          [_a].IdePgtoExt.IdePais.indNIF);
        mmoRetorno.Lines.Add('        nifBenef: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].IdePgtoExt.IdePais.nifBenef);
        // EndExt
        mmoRetorno.Lines.Add('        dscLograd: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].IdePgtoExt.EndExt.dscLograd);
        mmoRetorno.Lines.Add('        nrLograd: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].IdePgtoExt.EndExt.nrLograd);
        mmoRetorno.Lines.Add('        complem: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].IdePgtoExt.EndExt.complem);
        mmoRetorno.Lines.Add('        bairro: ' + RetConsultaItem.S5002.InfoIrrf
          [_a].IdePgtoExt.EndExt.bairro);
        mmoRetorno.Lines.Add('        nmCid: ' + RetConsultaItem.S5002.InfoIrrf
          [_a].IdePgtoExt.EndExt.nmCid);
        mmoRetorno.Lines.Add('        codPostal: ' +
          RetConsultaItem.S5002.InfoIrrf[_a].IdePgtoExt.EndExt.codPostal);
      end;
    end;

    if not RetConsultaItem.S5003.IsEmpty then
    begin
      mmoRetorno.Lines.Add('        ### S5003 ###');
      mmoRetorno.Lines.Add('        Id: ' + RetConsultaItem.S5003.Id);
      // IdeEvento
      mmoRetorno.Lines.Add('        NrRecArqBase: ' +
        RetConsultaItem.S5003.IdeEvento.NrRecArqBase);
      mmoRetorno.Lines.Add('        perApur: ' +
        RetConsultaItem.S5003.IdeEvento.perApur);

      // IdeEmpregador
      mmoRetorno.Lines.Add('        tpInsc: ' +
        RetConsultaItem.S5003.IdeEmpregador.tpInsc);
      mmoRetorno.Lines.Add('        nrInsc: ' +
        RetConsultaItem.S5003.IdeEmpregador.nrInsc);

      // ideTrabalhador

      mmoRetorno.Lines.Add('        CpfTrab: ' +
        RetConsultaItem.S5003.IdeTrabalador.cpfTrab);
      mmoRetorno.Lines.Add('        NisTrab: ' +
        RetConsultaItem.S5003.IdeTrabalador.NisTrab);

      // InfoFGTS
      mmoRetorno.Lines.Add('        InfoFGTS: ' +
        RetConsultaItem.S5003.InfoFGTS.DtVenc);
      mmoRetorno.Lines.Add('           CpfTrab: ' +
        RetConsultaItem.S5003.InfoFGTS.DtVenc);

      for _a := 0 to RetConsultaItem.S5003.InfoFGTS.CountIdeEstabLot - 1 do
      begin
        mmoRetorno.Lines.Add('           IdeEstabLot: ');
        mmoRetorno.Lines.Add('            TpInsc: ' +
          RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].tpInsc);
        mmoRetorno.Lines.Add('            NrInsc: ' +
          RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].nrInsc);
        mmoRetorno.Lines.Add('            CodLotacao: ' +
          RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].codLotacao);
        for _b := 0 to RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a]
          .CountInfoTrabFGTS - 1 do
        begin
          mmoRetorno.Lines.Add('            IdeEstabLot: ');
          mmoRetorno.Lines.Add('              Matricula: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
            .Matricula);
          mmoRetorno.Lines.Add('              CodCateg: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
            .codCateg);
          mmoRetorno.Lines.Add('              DtAdm: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS
            [_b].DtAdm);
          mmoRetorno.Lines.Add('              DtDeslig: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
            .DtDeslig);
          mmoRetorno.Lines.Add('              DtInicio: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
            .DtInicio);
          mmoRetorno.Lines.Add('              MtvDeslig: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
            .MtvDeslig);
          mmoRetorno.Lines.Add('              DtTerm: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS
            [_b].DtTerm);
          mmoRetorno.Lines.Add('              MtvDesligTSV: ' +
            RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
            .MtvDesligTSV);

          for _c := 0 to RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a]
            .InfoTrabFGTS[_b].CountInfoBaseFGTS - 1 do
          begin
            mmoRetorno.Lines.Add('               InfoBaseFGTS: ');
            for _d := 0 to RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a]
              .InfoTrabFGTS[_b].InfoBaseFGTS[_c].CountBasePerApur - 1 do
            begin
              mmoRetorno.Lines.Add('                BasePerApur: ');
              mmoRetorno.Lines.Add('                 tpValor: ' +
                RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
                .InfoBaseFGTS[_c].BasePerApur[_d].tpValor);
              mmoRetorno.Lines.Add('                 RemFGTS: ' +
                RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
                .InfoBaseFGTS[_c].BasePerApur[_d].RemFGTS);

            end;
            for _d := 0 to RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a]
              .InfoTrabFGTS[_b].InfoBaseFGTS[_c].CountInfoBasePerAntE - 1 do
            begin
              mmoRetorno.Lines.Add('                InfoBasePerAntE: ');
              mmoRetorno.Lines.Add('                 PerRef: ' +
                RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS[_b]
                .InfoBaseFGTS[_c].InfoBasePerAntE[_d].PerRef);

              for _e := 0 to RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a]
                .InfoTrabFGTS[_b].InfoBaseFGTS[_c].InfoBasePerAntE[_d]
                .CountBasePerAntE - 1 do
              begin
                mmoRetorno.Lines.Add('                 BasePerAntE: ');
                mmoRetorno.Lines.Add('                  TpValorE: ' +
                  RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS
                  [_b].InfoBaseFGTS[_c].InfoBasePerAntE[_d].BasePerAntE[_e]
                  .TpValorE);

                mmoRetorno.Lines.Add('                  RemFGTSE: ' +
                  RetConsultaItem.S5003.InfoFGTS.IdeEstabLot[_a].InfoTrabFGTS
                  [_b].InfoBaseFGTS[_c].InfoBasePerAntE[_d].BasePerAntE[_e]
                  .RemFGTSE);

              end;

            end;

          end;

        end;

      end;

      for _a := 0 to RetConsultaItem.S5003.InfoFGTS.CountInfoDpsFGTS - 1 do
      begin
        mmoRetorno.Lines.Add('           InfoDpsFGTS: ');
        for _b := 0 to RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a]
          .CountInfoTrabDps - 1 do
        begin
          mmoRetorno.Lines.Add('            InfoTrabDps: ');
          mmoRetorno.Lines.Add('             Matricula: ' +
            RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a].InfoTrabDps[_b]
            .Matricula);
          mmoRetorno.Lines.Add('             codCateg: ' +
            RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a].InfoTrabDps[_b]
            .codCateg);
          for _c := 0 to RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a]
            .InfoTrabDps[_b].CountDpsPerApur - 1 do
          begin
            mmoRetorno.Lines.Add('            DpsPerApur: ');
            mmoRetorno.Lines.Add('             TpDps: ' +
              RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a].InfoTrabDps[_b]
              .DpsPerApur[_c].TpDps);
            mmoRetorno.Lines.Add('             DpsFGTS: ' +
              RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a].InfoTrabDps[_b]
              .DpsPerApur[_c].DpsFGTS);
          end;
          for _c := 0 to RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a]
            .InfoTrabDps[_b].CountInfoDpsPerAntE - 1 do
          begin
            mmoRetorno.Lines.Add('            InfoDpsPerAntE: ');
            mmoRetorno.Lines.Add('             PerRef: ' +
              RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a].InfoTrabDps[_b]
              .InfoDpsPerAntE[_c].PerRef);

            for _d := 0 to RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a]
              .InfoTrabDps[_b].InfoDpsPerAntE[_c].CountDpsPerAntE - 1 do
            begin
              mmoRetorno.Lines.Add('             DpsPerAntE: ');
              mmoRetorno.Lines.Add('              TpDpsE: ' +
                RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a].InfoTrabDps[_b]
                .InfoDpsPerAntE[_c].DpsPerAntE[_d].TpDpsE);
              mmoRetorno.Lines.Add('              DpsFGTSE: ' +
                RetConsultaItem.S5003.InfoFGTS.InfoDpsFGTS[_a].InfoTrabDps[_b]
                .InfoDpsPerAntE[_c].DpsPerAntE[_d].DpsFGTSE);
            end;

          end;

        end;

      end;
    end;

    if not RetConsultaItem.S5011.IsEmpty then
    begin
      mmoRetorno.Lines.Add('        ### S5011 ###');
      mmoRetorno.Lines.Add('        Id: ' + RetConsultaItem.S5011.Id);
      // IdeEvento
      mmoRetorno.Lines.Add('        indApuracao: ' +
        RetConsultaItem.S5011.IdeEvento.indApuracao);
      mmoRetorno.Lines.Add('        perApur: ' +
        RetConsultaItem.S5011.IdeEvento.perApur);
      // IdeEmpregador
      mmoRetorno.Lines.Add('        tpInsc: ' +
        RetConsultaItem.S5011.IdeEmpregador.tpInsc);
      mmoRetorno.Lines.Add('        nrInsc: ' +
        RetConsultaItem.S5011.IdeEmpregador.nrInsc);
      // InfoCS
      mmoRetorno.Lines.Add('        nrRecArqBase: ' +
        RetConsultaItem.S5011.InfoCS.NrRecArqBase);
      mmoRetorno.Lines.Add('        indExistInfo: ' +
        RetConsultaItem.S5011.InfoCS.indExistInfo);
      // InfoCPSeg
      mmoRetorno.Lines.Add('        vrDescCP: ' +
        RetConsultaItem.S5011.InfoCS.InfoCPSeg.vrDescCP);
      mmoRetorno.Lines.Add('        vrCpSeg: ' +
        RetConsultaItem.S5011.InfoCS.InfoCPSeg.vrCpSeg);
      // InfoContrib
      mmoRetorno.Lines.Add('        classTrib: ' +
        RetConsultaItem.S5011.InfoCS.InfoContrib.classTrib);
      // InfoPJ
      mmoRetorno.Lines.Add('        indCoop: ' +
        RetConsultaItem.S5011.InfoCS.InfoContrib.InfoPJ.indCoop);
      mmoRetorno.Lines.Add('        indConstr: ' +
        RetConsultaItem.S5011.InfoCS.InfoContrib.InfoPJ.indConstr);
      mmoRetorno.Lines.Add('        indSubstPatr: ' +
        RetConsultaItem.S5011.InfoCS.InfoContrib.InfoPJ.indSubstPatr);
      mmoRetorno.Lines.Add('        percRedContrib: ' +
        RetConsultaItem.S5011.InfoCS.InfoContrib.InfoPJ.percRedContrib);
      // InfoAtConc
      mmoRetorno.Lines.Add('        fatorMes: ' +
        RetConsultaItem.S5011.InfoCS.InfoContrib.InfoPJ.InfoAtConc.fatorMes);
      mmoRetorno.Lines.Add('        fator13: ' +
        RetConsultaItem.S5011.InfoCS.InfoContrib.InfoPJ.InfoAtConc.fator13);
      // IdeEstab
      for _a := 0 to RetConsultaItem.S5011.InfoCS.CountIdeEstab - 1 do
      begin
        mmoRetorno.Lines.Add('        tpInsc: ' +
          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].tpInsc);
        mmoRetorno.Lines.Add('        nrInsc: ' +
          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].nrInsc);
        // InfoEstab
        mmoRetorno.Lines.Add('        cnaePrep: ' +
          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].InfoEstab.cnaePrep);
        mmoRetorno.Lines.Add('        aliqRat: ' +
          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].InfoEstab.aliqRat);
        mmoRetorno.Lines.Add('        fap: ' +
          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].InfoEstab.fap);
        mmoRetorno.Lines.Add('        aliqRatAjust: ' +
          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].InfoEstab.aliqRatAjust);
        // InfoComplObra
        mmoRetorno.Lines.Add('        indSubstPatrObra: ' +
          RetConsultaItem.S5011.InfoCS.IdeEstab[_a]
          .InfoEstab.InfoComplObra.indSubstPatrObra);
        // IdeLotacao
        for _b := 0 to RetConsultaItem.S5011.InfoCS.IdeEstab[_a]
          .CountIdeLotacao - 1 do
        begin
          mmoRetorno.Lines.Add('        codLotacao: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .codLotacao);
          mmoRetorno.Lines.Add('        fpas: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b].fpas);
          mmoRetorno.Lines.Add('        codTercs: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b].codTercs);
          mmoRetorno.Lines.Add('        codTercsSusp: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .codTercsSusp);
          // InfoTercSusp
          for _c := 0 to RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao
            [_b].CountInfoTercSusp - 1 do
          begin
            mmoRetorno.Lines.Add('        codTerc: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .InfoTercSusp[_c].codTerc);
          end;
          // InfoEmprParcial
          mmoRetorno.Lines.Add('        tpInscContrat: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .InfoEmprParcial.tpInscContrat);
          mmoRetorno.Lines.Add('        nrInscContrat: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .InfoEmprParcial.nrInscContrat);
          mmoRetorno.Lines.Add('        tpInscProp: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .InfoEmprParcial.tpInscProp);
          mmoRetorno.Lines.Add('        nrInscProp: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .InfoEmprParcial.nrInscProp);
          // DadosOpPort
          mmoRetorno.Lines.Add('        cnpjOpPortuario: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .DadosOpPort.cnpjOpPortuario);
          mmoRetorno.Lines.Add('        aliqRat: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .DadosOpPort.aliqRat);
          mmoRetorno.Lines.Add('        fap: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .DadosOpPort.fap);
          mmoRetorno.Lines.Add('        aliqRatAjust: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .DadosOpPort.aliqRatAjust);
          // BasesRemun
          for _c := 0 to RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao
            [_b].CountBasesRemun - 1 do
          begin
            mmoRetorno.Lines.Add('        indIncid: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].indIncid);
            mmoRetorno.Lines.Add('        codCateg: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].codCateg);
            // BasesCp
            mmoRetorno.Lines.Add('        vrBcCp00: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrBcCp00);
            mmoRetorno.Lines.Add('        vrBcCp15: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrBcCp15);
            mmoRetorno.Lines.Add('        vrBcCp20: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrBcCp20);
            mmoRetorno.Lines.Add('        vrBcCp25: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrBcCp25);
            mmoRetorno.Lines.Add('        vrSuspBcCp00: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrSuspBcCp00);
            mmoRetorno.Lines.Add('        vrSuspBcCp15: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrSuspBcCp15);
            mmoRetorno.Lines.Add('        vrSuspBcCp20: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrSuspBcCp20);
            mmoRetorno.Lines.Add('        vrSuspBcCp25: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrSuspBcCp25);
            mmoRetorno.Lines.Add('        vrDescSest: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrDescSest);
            mmoRetorno.Lines.Add('        vrCalcSest: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrCalcSest);
            mmoRetorno.Lines.Add('        vrDescSenat: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrDescSenat);
            mmoRetorno.Lines.Add('        vrCalcSenat: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrCalcSenat);
            mmoRetorno.Lines.Add('        vrSalFam: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrSalFam);
            mmoRetorno.Lines.Add('        vrSalMat: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrSalMat);
            mmoRetorno.Lines.Add('        vrBcCp00VA: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .BasesRemun[_c].BasesCp.vrBcCp00VA);
            mmoRetorno.Lines.Add('        vrBcCp15VA: ' +
                          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
                          .BasesRemun[_c].BasesCp.vrBcCp15VA);
            mmoRetorno.Lines.Add('        vrBcCp20VA: ' +
                          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
                          .BasesRemun[_c].BasesCp.vrBcCp20VA);
            mmoRetorno.Lines.Add('        vrBcCp25VA: ' +
                          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
                          .BasesRemun[_c].BasesCp.vrBcCp25VA);
            mmoRetorno.Lines.Add('        vrSuspBcCp00VA: ' +
                          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
                          .BasesRemun[_c].BasesCp.vrSuspBcCp00VA);
            mmoRetorno.Lines.Add('        vrSuspBcCp15VA: ' +
                          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
                          .BasesRemun[_c].BasesCp.vrSuspBcCp15VA);
            mmoRetorno.Lines.Add('        vrSuspBcCp20VA: ' +
                          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
                          .BasesRemun[_c].BasesCp.vrSuspBcCp20VA);
            mmoRetorno.Lines.Add('        vrSuspBcCp25VA: ' +
                          RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
                          .BasesRemun[_c].BasesCp.vrSuspBcCp25VA);
          end;
          // BasesAvNPort
          mmoRetorno.Lines.Add('        vrBcCp00: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .BasesAvNPort.vrBcCp00);
          mmoRetorno.Lines.Add('        vrBcCp15: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .BasesAvNPort.vrBcCp15);
          mmoRetorno.Lines.Add('        vrBcCp20: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .BasesAvNPort.vrBcCp20);
          mmoRetorno.Lines.Add('        vrBcCp25: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .BasesAvNPort.vrBcCp25);
          mmoRetorno.Lines.Add('        vrBcCp13: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .BasesAvNPort.vrBcCp13);
          mmoRetorno.Lines.Add('        vrBcFgts: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .BasesAvNPort.vrBcFgts);
          mmoRetorno.Lines.Add('        vrDescCP: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
            .BasesAvNPort.vrDescCP);
          // InfoSubstPatrOpPort
          for _c := 0 to RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao
            [_b].CountInfoSubstPatrOpOrt - 1 do
          begin
            mmoRetorno.Lines.Add('        cnpjOpPortuario: ' +
              RetConsultaItem.S5011.InfoCS.IdeEstab[_a].IdeLotacao[_b]
              .InfoSubstPatrOpPort[_c].cnpjOpPortuario);
          end;
        end;
        // BasesAquis
        for _b := 0 to RetConsultaItem.S5011.InfoCS.IdeEstab[_a]
          .CountBasesAquis - 1 do
        begin
          mmoRetorno.Lines.Add('        indAquis: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b].indAquis);
          mmoRetorno.Lines.Add('        vlrAquis: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b].vlrAquis);
          mmoRetorno.Lines.Add('        vrCPDescPR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b]
            .vrCPDescPR);
          mmoRetorno.Lines.Add('        vrCPNRet: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b].vrCPNRet);
          mmoRetorno.Lines.Add('        vrRatNRet: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b].vrRatNRet);
          mmoRetorno.Lines.Add('        vrSenarNRet: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b]
            .vrSenarNRet);
          mmoRetorno.Lines.Add('        vrCPCalcPR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b]
            .vrCPCalcPR);
          mmoRetorno.Lines.Add('        vrRatDescPR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b]
            .vrRatDescPR);
          mmoRetorno.Lines.Add('        vrRatCalcPR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b]
            .vrRatCalcPR);
          mmoRetorno.Lines.Add('        vrSenarDesc: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b]
            .vrSenarDesc);
          mmoRetorno.Lines.Add('        vrSenarCalc: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesAquis[_b]
            .vrSenarCalc);
        end;
        // BasesComerc
        for _b := 0 to RetConsultaItem.S5011.InfoCS.IdeEstab[_a]
          .CountBasesComerc - 1 do
        begin
          mmoRetorno.Lines.Add('        indComerc: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesComerc[_b]
            .indComerc);
          mmoRetorno.Lines.Add('        vrBcComPR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesComerc[_b]
            .vrBcComPR);
          mmoRetorno.Lines.Add('        vrCPSusp: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesComerc[_b].vrCPSusp);
          mmoRetorno.Lines.Add('        vrRatSusp: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesComerc[_b]
            .vrRatSusp);
          mmoRetorno.Lines.Add('        vrSenarSusp: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].BasesComerc[_b]
            .vrSenarSusp);
        end;
        // InfoCREstab
        for _b := 0 to RetConsultaItem.S5011.InfoCS.IdeEstab[_a]
          .CountInfoCREstab - 1 do
        begin
          mmoRetorno.Lines.Add('        tpCR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].InfoCREstab[_b].tpCR);
          mmoRetorno.Lines.Add('        vrCR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].InfoCREstab[_b].vrCR);
          mmoRetorno.Lines.Add('        vrSuspCR: ' +
            RetConsultaItem.S5011.InfoCS.IdeEstab[_a].InfoCREstab[_b].vrSuspCR);
        end;
      end;
      // infoCRContrib
      for _a := 0 to RetConsultaItem.S5011.InfoCS.CountInfoCRContrib - 1 do
      begin
        mmoRetorno.Lines.Add('        tpCR: ' +
          RetConsultaItem.S5011.InfoCS.infoCRContrib[_a].tpCR);
        mmoRetorno.Lines.Add('        vrCR: ' +
          RetConsultaItem.S5011.InfoCS.infoCRContrib[_a].vrCR);
        mmoRetorno.Lines.Add('        vrCRSusp: ' +
          RetConsultaItem.S5011.InfoCS.infoCRContrib[_a].vrCRSusp);
      end;
    end;
    if not RetConsultaItem.S5012.IsEmpty then
    begin
      mmoRetorno.Lines.Add('        ### S5012 ###');
      mmoRetorno.Lines.Add('        Id: ' + RetConsultaItem.S5012.Id);
      // IdeEvento
      mmoRetorno.Lines.Add('        perApur: ' +
        RetConsultaItem.S5012.IdeEvento.perApur);
      // IdeEmpregador
      mmoRetorno.Lines.Add('        tpInsc: ' +
        RetConsultaItem.S5012.IdeEmpregador.tpInsc);
      mmoRetorno.Lines.Add('        nrInsc: ' +
        RetConsultaItem.S5012.IdeEmpregador.nrInsc);
      // InfoIrrf
      mmoRetorno.Lines.Add('        nrRecArqBase: ' +
        RetConsultaItem.S5012.InfoIrrf.NrRecArqBase);
      mmoRetorno.Lines.Add('        indExistInfo: ' +
        RetConsultaItem.S5012.InfoIrrf.indExistInfo);
      // InfoCRContrib
      for _a := 0 to RetConsultaItem.S5012.InfoIrrf.CountInfoCRContrib - 1 do
      begin
        mmoRetorno.Lines.Add('        tpCR: ' +
          RetConsultaItem.S5012.InfoIrrf.infoCRContrib[_a].tpCR);
        mmoRetorno.Lines.Add('        vrCR: ' +
          RetConsultaItem.S5012.InfoIrrf.infoCRContrib[_a].vrCR);
      end;
    end;

    if not RetConsultaItem.S5013.IsEmpty then
    begin
      mmoRetorno.Lines.Add('        ### S5013 ###');
      mmoRetorno.Lines.Add('        Id: ' + RetConsultaItem.S5013.Id);
      // IdeEvento
      mmoRetorno.Lines.Add('        perApur: ' +
        RetConsultaItem.S5013.IdeEvento.perApur);
      // IdeEmpregador
      mmoRetorno.Lines.Add('        tpInsc: ' +
        RetConsultaItem.S5013.IdeEmpregador.tpInsc);
      mmoRetorno.Lines.Add('        nrInsc: ' +
        RetConsultaItem.S5013.IdeEmpregador.nrInsc);
      // infoFGTS
      mmoRetorno.Lines.Add('        nrRecArqBase: ' +
        RetConsultaItem.S5013.InfoFGTS.NrRecArqBase);
      mmoRetorno.Lines.Add('        indExistInfo: ' +
        RetConsultaItem.S5013.InfoFGTS.indExistInfo);
      // infoBaseFGTS
      mmoRetorno.Lines.Add('        infoBaseFGTS: ');
      // basePerApur
      mmoRetorno.Lines.Add('          basePerApur: <List>');
      for _a := 0 to RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.
        CountBasePerApur - 1 do
      begin
        mmoRetorno.Lines.Add('            tpValor: ' +
          RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.BasePerApur[_a].tpValor);
        mmoRetorno.Lines.Add('            baseFGTS: ' +
          RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.BasePerApur[_a].baseFGTS);
        mmoRetorno.Lines.Add('            --');
      end;
      // infoBaseFGTS
      mmoRetorno.Lines.Add('          infoBaseFGTS: <List>');
      for _a := 0 to RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.
        CountInfoBasePerAntE - 1 do
      begin
        // InfoBasePerAntE
        mmoRetorno.Lines.Add('            perRef: ' +
          RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.InfoBasePerAntE
          [_a].PerRef);
        mmoRetorno.Lines.Add('            basePerAntE: <List>');
        for _b := 0 to RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.
          InfoBasePerAntE[_a].CountBasePerAntE - 1 do
        begin
          mmoRetorno.Lines.Add('              tpValorE: ' +
            RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.InfoBasePerAntE[_a]
            .BasePerAntE[_b].TpValorE);
          mmoRetorno.Lines.Add('              baseFGTSE: ' +
            RetConsultaItem.S5013.InfoFGTS.InfoBaseFGTS.InfoBasePerAntE[_a]
            .BasePerAntE[_b].baseFGTSE);
          mmoRetorno.Lines.Add('              --');
        end;
      end;
      // infoDpsFGTS
      mmoRetorno.Lines.Add('          infoDpsFGTS:');
      // dpsPerApur
      for _a := 0 to RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.
        CountDpsPerApur - 1 do
      begin
        mmoRetorno.Lines.Add('            TpDps: ' +
          RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.DpsPerApur[_a].TpDps);
        mmoRetorno.Lines.Add('            VrFGTS: ' +
          RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.DpsPerApur[_a].VrFGTS);
        mmoRetorno.Lines.Add('            --');
      end;
      // infoDpsPerAntE
      mmoRetorno.Lines.Add('          infoDpsPerAntE: <List>');
      for _a := 0 to RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.
        CountInfoDpsPerAntE - 1 do
      begin
        mmoRetorno.Lines.Add('            perRef: ' +
          RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.InfoDpsPerAntE[_a].PerRef);
        // basePerAntE
        mmoRetorno.Lines.Add('            basePerAntE: <List>');
        for _b := 0 to RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.InfoDpsPerAntE
          [_a].CountDpsPerAntE - 1 do
        begin
          mmoRetorno.Lines.Add('              TpDpsE: ' +
            RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.InfoDpsPerAntE[_a]
            .DpsPerAntE[_b].TpDpsE);
          mmoRetorno.Lines.Add('              vrFGTSE: ' +
            RetConsultaItem.S5013.InfoFGTS.InfoDpsFGTS.InfoDpsPerAntE[_a]
            .DpsPerAntE[_b].VrFGTSE);
          mmoRetorno.Lines.Add('              --');
        end;
      end;
    end;

    for _j := 0 to RetConsultaItem.Count - 1 do
    begin
      RetConsultaOcorrencia := RetConsultaItem.Ocorrencias[_j];
      mmoRetorno.Lines.Add('        Ocorrencia: ' + IntToStr(_j + 1));
      mmoRetorno.Lines.Add('        C�digo: ' + RetConsultaOcorrencia.Codigo);
      mmoRetorno.Lines.Add('        Descri��o: ' +
        RetConsultaOcorrencia.Descricao);
      mmoRetorno.Lines.Add('        Tipo: ' + RetConsultaOcorrencia.Tipo);
      mmoRetorno.Lines.Add('        Localiza��o: ' +
        RetConsultaOcorrencia.Localizacao);
    end;
  end;
  for _k := 0 to RetConsulta.CountOcorrencias - 1 do
  begin
    RetConsultaOcorrenciaEnvio := RetConsulta.Ocorrencias[_k];
    mmoRetorno.Lines.Add('    Codigo: ' + RetConsultaOcorrenciaEnvio.Codigo);
    mmoRetorno.Lines.Add('    Tipo: ' + RetConsultaOcorrenciaEnvio.Tipo);
    mmoRetorno.Lines.Add('    Localiza��o: ' +
      RetConsultaOcorrenciaEnvio.Localizacao);
    mmoRetorno.Lines.Add('    Descri��o: ' +
      RetConsultaOcorrenciaEnvio.Descricao);
  end;

  mmoXmlEnvio.Text := RetConsulta.XmlEnviado;
  mmoXmlRetorno.Text := RetConsulta.XmlRetorno;
end;

procedure TfrmeSocial.btnConsultarIdsEventoLoteClick(Sender: TObject);
var
  RetConsultaIdsEventoLote: IspdRetConsultarIdsEventosLote;
  RetConsultaIdsEventoLoteItem: IspdRetConsultarIdsEventosLoteItem;
  _i: integer;
begin
  if edtIdLote.Text = '' then
    ShowMessage('Por preencher o identificador do lote');

  RetConsultaIdsEventoLote := eSocial.ConsultarIdsEventoLote(edtIdLote.Text);

  mmoRetorno.Lines.Clear;
  mmoRetorno.Lines.Add('### CONSULTA IDS EVENTOS LOTE ###');
  mmoRetorno.Lines.Add('N�mero do Protocolo: ' + RetConsultaIdsEventoLote.NumeroProtocolo);
  mmoRetorno.Lines.Add('Mensagem de Retorno: ' + RetConsultaIdsEventoLote.Mensagem);

  mmoRetorno.Lines.Add('Id do Lote: ' + RetConsultaIdsEventoLote.IdLote);
  for _i := 0 to RetConsultaIdsEventoLote.Count - 1 do
  begin
    RetConsultaIdsEventoLoteItem := RetConsultaIdsEventoLote.Eventos[_i];
    mmoRetorno.Lines.Add('    Evento: ' + IntToStr(_i + 1));
    mmoRetorno.Lines.Add('    Id Evento: ' + RetConsultaIdsEventoLoteItem.IdEvento);
 end
end;

procedure TfrmeSocial.btnEnviarClick(Sender: TObject);
var
  RetEnvio: IspdRetEnviarLoteEventos;
begin
  RetEnvio := eSocial.EnviarLoteEventos(mmoRetorno.Text,
    StrToInt(cbGrupo.Text));
  mmoRetorno.Lines.Clear;
  mmoRetorno.Lines.Add('### INCLUIR EVENTO ###');
  mmoRetorno.Lines.Add('Identificador do Lote: ' + RetEnvio.IdLote);
  mmoRetorno.Lines.Add('Mensagem de Retorno: ' + RetEnvio.Mensagem);
  edtIdLote.Text := RetEnvio.IdLote;
end;

procedure TfrmeSocial.btnTx2Click(Sender: TObject);
begin
  mmoRetorno.Clear;
  mmoRetorno.Lines.Add('INCLUIRS1000');
  if cbAmbiente.Text = '1 - Produ��o' then
    mmoRetorno.Lines.Add('tpAmb_4=1');
  if cbAmbiente.Text = '2 - Homologa��o' then
    mmoRetorno.Lines.Add('tpAmb_4=2');
  mmoRetorno.Lines.Add('procEmi_5=1');
  mmoRetorno.Lines.Add('verProc_6=1.0');
  mmoRetorno.Lines.Add('tpInsc_8=1');
  mmoRetorno.Lines.Add('nrInsc_9=08187168');
  mmoRetorno.Lines.Add('iniValid_13=2017-07');
  mmoRetorno.Lines.Add('nmRazao_15=TECNOSPEED TECNOLOGIA DA INFORMACAO');
  mmoRetorno.Lines.Add('classTrib_16=99');
  mmoRetorno.Lines.Add('natJurid_17=2054');
  mmoRetorno.Lines.Add('indCoop_18=0');
  mmoRetorno.Lines.Add('indConstr_19=0');
  mmoRetorno.Lines.Add('indDesFolha_20=0');
  mmoRetorno.Lines.Add('indOptRegEletron_21=0');
  mmoRetorno.Lines.Add('indEntEd_23=N');
  mmoRetorno.Lines.Add('indEtt_24=N');
  mmoRetorno.Lines.Add('nmCtt_36=V�tor Beal');
  mmoRetorno.Lines.Add('cpfCtt_37=09336330926');
  mmoRetorno.Lines.Add('foneCel_39=7867834687');
  mmoRetorno.Lines.Add('foneFixo_38=4430379500');
  mmoRetorno.Lines.Add('indSitPJ_63=0');
  mmoRetorno.Lines.Add('SALVARS1000');
end;

procedure TfrmeSocial.btnXMLClick(Sender: TObject);
begin
  mmoRetorno.Text := eSocial.GerarXMLporTx2(mmoRetorno.Text);
end;

procedure TfrmeSocial.Button1Click(Sender: TObject);
begin
  eSocial.ReconsultarLoteSefaz(edtIdLote.Text);
  mmoRetorno.Text := 'Consulta enviada com sucesso! Realize a consulta normal para que possa verificar o retorno do eSocial.';
end;

procedure TfrmeSocial.FormCreate(Sender: TObject);
begin
  eSocial := TspdESocialClientX.Create(nil);
  frmeSocial.Caption := 'eSocial - TecnoSpeed - ' + eSocial.Versao;
  cbVersaoManual.Items.Text := eSocial.ListarVersaoManual(#13#10);
  cbCertificado.Items.Text := eSocial.ListarCertificados(#13#10);
  cbVersaoManual.ItemIndex := 0;
  cbCertificado.ItemIndex := 0;
end;

procedure TfrmeSocial.FormDestroy(Sender: TObject);
begin
  eSocial.Free;
end;

end.

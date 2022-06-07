unit uBaseIcmsST;

interface

uses
  uBaseIcmsProprio;

type
  TBaseIcmsST = class
  private
    FBaseIcmsProprio: TBaseIcmsProprio;
    FPercentualReducaoST: currency;
    FMva: currency;
    FValorIpi: currency;
  public
    constructor Create(_baseIcmsProprio: TBaseIcmsProprio;
                       _mva: currency;
                       _percentualReducaoST: currency = 0;
                       _valorIpi: currency = 0);
    function CalcularBaseIcmsST: currency;
    function CalcularBaseNormalST: currency;
    function CalcularBaseReduzidaST: currency;
    function ContemReducaoST: boolean;
  end;

implementation

uses
  acbrutil.Math;

{ TBaseIcmsST }

constructor TBaseIcmsST.Create(_baseIcmsProprio: TBaseIcmsProprio;
                               _mva,
                               _percentualReducaoST,
                               _valorIpi: currency);
begin
  FBaseIcmsProprio := _baseIcmsProprio;
  FMva := _mva;
  FPercentualReducaoST := _percentualReducaoST;
  FValorIpi := _valorIpi;
end;

function TBaseIcmsST.CalcularBaseIcmsST: currency;
begin
  if(FPercentualReducaoST > 0) then
    result := CalcularBaseReduzidaST
  else
    result := CalcularBaseNormalST;

end;

function TBaseIcmsST.CalcularBaseNormalST: currency;
begin
    Result := RoundABNT((FBaseIcmsProprio.CalcularBaseIcmsProprio + FValorIpi) *
                        (1 + (FMva / 100)), 2);
end;

function TBaseIcmsST.CalcularBaseReduzidaST: currency;
var
  baseIcmsST: currency;
begin
   baseIcmsST := RoundABNT((FBaseIcmsProprio.CalcularBaseIcmsProprio) *
                             (1 + (FMva / 100)), 2);

    Result := RoundABNT((baseIcmsST -
                        (baseIcmsST * (FPercentualReducaoST / 100)) +
                        FValorIpi), 2);
end;

function TBaseIcmsST.ContemReducaoST: boolean;
begin
 result := FPercentualReducaoST > 0;
end;



end.

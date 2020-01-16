unit uSubstitui;

interface

uses
  uISubstitui;

type

  TSubstitui = class(TInterfacedObject, ISubstitui)
  public
    function Substituir(aStr, aVelho, aNovo: String): String;
  end;

implementation

function TSubstitui.Substituir(aStr, aVelho, aNovo: String): String;

  //Devolve parte da string a partir da posição inicial até a final
  function CortaString(pStr: String; pPosInicial, pPosFinal: Integer): String;
  var
    aResultado: String;
    aPosicao: Integer;
  begin
    aResultado := '';
    for aPosicao := pPosInicial to pPosFinal do
    begin
      aResultado := aResultado + pStr[aPosicao];
    end;
    Result := aResultado;
  end;

  //Devolve a string substituindo o valor de aVelho contido em pStr pelo aNovo
  function Substitui(pStr: String): String;
  var
    aPosicao,
    aQntCaracteres: Integer;
    aResultado: String;
  begin
    aQntCaracteres := 0;
    aResultado := '';

    for aPosicao := 1 to Length(pStr) do
    begin
      if pStr[aPosicao] = aVelho[aQntCaracteres+1] then
        aQntCaracteres := aQntCaracteres + 1
      else begin
        aQntCaracteres := 0;

        if pStr[aPosicao] = aVelho[1] then
          aQntCaracteres := 1;
      end;

      if aQntCaracteres = Length(aVelho) then begin
        aResultado := CortaString(pStr, 1, aPosicao - aQntCaracteres) + aNovo;
        aResultado := aResultado + Substitui(CortaString(pStr, aPosicao +1, Length(pStr)));
        Break;
      end;
    end;

    if aResultado = '' then
      aResultado := pStr;

    Result := aResultado;
  end;

begin
  Result := Substitui(aStr);
end;

end.



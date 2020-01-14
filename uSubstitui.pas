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
    aPosicao: Integer;
  begin
    Result := '';
    for aPosicao := pPosInicial to pPosFinal do
    begin
      Result := Result + pStr[aPosicao];  
    end; 
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

    if Length(pStr) > 0 then begin
      if Length(aVelho) > 0 then
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
            Result := aResultado + Substitui(CortaString(pStr, aPosicao +1, Length(pStr)));
            Exit;
          end;
        end
    end else
      if Length(aVelho) = 0 then
        aResultado := aNovo;

    if aResultado = '' then
      aResultado := pStr;

    Result := aResultado;
  end;

begin
  Result := Substitui(aStr);
end;

end.



unit ViaCEP.Model;

interface

uses REST.Json.Types;

type
  TViaCEPClass = class
  private
    [JSONNameAttribute('cep')]
    FCEP: WideString;
    [JSONNameAttribute('logradouro')]
    FLogradouro: WideString;
    [JSONNameAttribute('localidade')]
    FLocalidade: WideString;
    [JSONNameAttribute('bairro')]
    FBairro: WideString;
    [JSONNameAttribute('uf')]
    FUF: WideString;
    [JSONNameAttribute('complemento')]
    FComplemento: WideString;
  public
    function ObterValor(pIndex: Integer): WideString;
    procedure ReceberValor(pIndex:Integer; pValue: WideString);
    procedure Clear;
    property CEP: WideString index 0 read ObterValor write ReceberValor;
    property Logradouro: WideString index 1 read ObterValor write ReceberValor;
    property Localidade: WideString index 2 read ObterValor write ReceberValor;
    property Bairro: WideString index 3 read ObterValor write ReceberValor;
    property UF: WideString index 4 read ObterValor write ReceberValor;
    property Complemento: WideString index 5 read ObterValor write ReceberValor;
    function ToJSONString: string;
    //class function FromJSONString(const AJSONString: string): TViaCEPClass;
  end;

implementation

uses REST.Json, ViaCEP.Utils, System.SysUtils;

{ TViaCEPClass }

procedure TViaCEPClass.Clear;
begin
  FCEP := EmptyWideStr;
  FLogradouro := EmptyWideStr;
  FLocalidade := EmptyWideStr;
  FBairro:= EmptyWideStr;
  FUF := EmptyWideStr;
  FComplemento := EmptyWideStr;
end;

//class function TViaCEPClass.FromJSONString(const AJSONString: string): TViaCEPClass;
//begin
//  Result := TJson.JsonToObject<TViaCEPClass>(AJSONString);
//end;

function TViaCEPClass.ObterValor(pIndex: Integer): WideString;
begin
  case pIndex of
    0: Result := FCEP;
    1: Result := FLogradouro;
    2: Result := FLocalidade;
    3: Result := FBairro;
    4: Result := FUF;
    5: Result := FComplemento;
  end;
end;

procedure TViaCEPClass.ReceberValor(pIndex: Integer; pValue: WideString);
begin
  case pIndex of
    0: FCEP := RemoveCharacter(pValue);
    1: FLogradouro := pValue;
    2: FLocalidade := pValue;
    3: FBairro:= pValue;
    4: FUF := pValue;
    5: FComplemento := pValue;
  end;
end;

function TViaCEPClass.ToJSONString: string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.

unit ViaCEP.Utils;

interface

function RemoveCharacter(const ACep: string): String; overload;
function RemoveCharacter(const ACep: Variant): String; overload;
function ConcatParam(const AValue: String): String;
function ParseArrayJson(const AValue: String): String;

implementation

uses System.SysUtils, Variants, System.JSON;

function RemoveCharacter(const ACep: string): String;
begin
  Result := StringReplace(ACep,'-','', [rfReplaceAll]);
  Result := StringReplace(Result,'.','', [rfReplaceAll]);
end;

function RemoveCharacter(const ACep: Variant): String;
begin
  Result := VarToStr(ACep);
  Result := StringReplace(ACep,'-','', [rfReplaceAll]);
  Result := StringReplace(Result,'.','', [rfReplaceAll]);
end;

function ConcatParam(const AValue: String): String;
begin
  Result := StringReplace(AValue.Trim,' ','%20',[rfReplaceAll]);
end;

function ParseArrayJson(const AValue: String): String;
var
  JsonValue: TJSONValue;
begin
   JsonValue := TJSONObject.ParseJSONValue(AValue);

   Result := TJSONArray(JsonValue).Items[0].ToString;
end;


end.

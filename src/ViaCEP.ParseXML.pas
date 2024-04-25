unit ViaCEP.ParseXML;

interface

uses
  Xml.XMLDoc, Xml.XmlIntf, System.SysUtils, System.Classes, ViaCEP.Model;

type
  TXmlCepParser = class
  public
    class procedure ParseXml(StringXML: String; var obj: TViaCEPClass);
  end;

implementation

{ TXmlCepParser }

class procedure TXmlCepParser.ParseXml(StringXML: String; var obj: TViaCEPClass);
var
  nodeEnderecos: IXMLNode;
  nodeEndereco: IXMLNode;
  XMLDoc : IXMLDocument;
  i: Integer;
begin
  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.LoadFromXML(StringXML);
  XMLDoc.Active := True;

  if not Assigned(XMLDoc) then
    Exit;

  if XMLDoc.DocumentElement.NodeName <> 'xmlcep' then
    Exit;

  try
    if Assigned(XMLDoc.DocumentElement.ChildNodes.FindNode('enderecos')) then
    begin
      nodeEnderecos := XMLDoc.DocumentElement.ChildNodes['enderecos'];

      nodeEndereco := nodeEnderecos.ChildNodes['endereco'];

      if Assigned(nodeEndereco) then
      begin
        obj.CEP := nodeEndereco.ChildNodes.Nodes['cep'].Text;
        obj.Logradouro := nodeEndereco.ChildNodes.Nodes['logradouro'].Text;
        obj.Localidade := nodeEndereco.ChildNodes.Nodes['localidade'].Text;
        obj.Bairro := nodeEndereco.ChildNodes.Nodes['bairro'].Text;
        obj.UF := nodeEndereco.ChildNodes.Nodes['uf'].Text;
        obj.Complemento := nodeEndereco.ChildNodes.Nodes['complemento'].Text;
      end;
    end
    else
    begin
      obj.CEP := XMLDoc.DocumentElement.ChildNodes['cep'].Text;
      obj.Logradouro := XMLDoc.DocumentElement.ChildNodes['logradouro'].Text;
      obj.Localidade := XMLDoc.DocumentElement.ChildNodes['localidade'].Text;
      obj.Bairro := XMLDoc.DocumentElement.ChildNodes['bairro'].Text;
      obj.UF := XMLDoc.DocumentElement.ChildNodes['uf'].Text;
      obj.Complemento := XMLDoc.DocumentElement.ChildNodes['complemento'].Text;
    end;

  finally
    nodeEnderecos := Nil;
    nodeEndereco := Nil;
    XMLDoc := Nil;
  end;
end;

end.


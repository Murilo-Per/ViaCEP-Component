# ViaCEP-Component
Componente Delphi que consome API ViaCEP

## Pré-requisitos
 * `[Opcional]` Para facilitar o gerenciamento de dependências, eu recomendo utilizar o Boss.
   * [**Boss**](https://github.com/HashLoad/boss) - Gerenciador de dependências para Delphi
 * Possuir as dlls **libeay32.dll** e **ssleay32.dll** na pasta do projeto junto ao executável.
 
## Instalação utilizando o Boss
```
boss install github.com/Murilo-Per/ViaCEP-Component
```

## Instalação manual
Adicione a seguinte pasta no seu projeto em *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*
```
../viacep-component/src
```

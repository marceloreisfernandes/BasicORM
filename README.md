# BasicORM

BasicORM e um experimento de ORM em Delphi/VCL usando RTTI, atributos customizados e FireDAC.

O objetivo do projeto e mapear classes Delphi para tabelas do banco de dados por meio de atributos, reduzindo a necessidade de escrever SQL manual para operacoes basicas de persistencia.

## Status

Projeto em desenvolvimento.

Ja existe suporte inicial para:

- Declarar o nome da tabela com atributo na classe.
- Declarar campos de chave primaria com atributo na propriedade.
- Ler metadados da classe via RTTI.
- Criar comandos DAO usando FireDAC.
- Controlar transacoes pelo DAO.

Ainda pendente:

- Implementacao de `Insert`.
- Implementacao de `Save`.
- Ampliacao dos tipos suportados no binding de parametros.
- Testes automatizados.
- Revisao do fluxo de `Delete`.

## Estrutura

```text
BasicORM.dpr                  Projeto Delphi/VCL
BasicORM.dproj                Arquivo do projeto Delphi
class/attributes.pas          Atributos e funcoes de reflection
class/daouib.pas              DAO baseado em FireDAC
interface/Interfaces.base.pas Interfaces e classe base de tabela
test/model.teste.pas          Modelo de exemplo
test/U_Test.pas               Formulario de teste
```

## Conceitos Principais

### Classe base

Toda entidade mapeada deve herdar de `TTable`.

```pascal
TTable = class(TObject)
end;
```

### Nome da tabela

Use `TNameTable` na classe para informar o nome da tabela no banco:

```pascal
[TNameTable('Teste')]
TTeste = class(TTable)
end;
```

### Chave primaria

Use `TFieldPK` na propriedade que representa a chave primaria:

```pascal
[TFieldPK]
property Id: Integer read FId write SetId;
```

## Exemplo

```pascal
uses
  attributes,
  Interfaces.base;

type
  [TNameTable('Teste')]
  TTeste = class(TTable)
  private
    FId: Integer;
    FDescricao: string;
  public
    [TFieldPK]
    property Id: Integer read FId write FId;

    property Descricao: string read FDescricao write FDescricao;
  end;
```

Para ler os metadados:

```pascal
var
  Tabela: TTeste;
  Pks: TResultArray;
begin
  Tabela := TTeste.Create;
  try
    Writeln(GetNameTable(Tabela));
    Pks := GetPks(Tabela);
  finally
    Tabela.Free;
  end;
end;
```

## DAO

`TDaoUib` implementa `IDaoBase` e recebe uma conexao e uma transacao FireDAC:

```pascal
Dao := TDaoUib.Create(FDConnection1, FDTransaction1);
```

Metodos disponiveis:

- `Insert`
- `Save`
- `Delete`
- `InTransaction`
- `StartTransaction`
- `Commit`
- `RollBack`

No estado atual, `Insert` e `Save` ainda nao possuem implementacao.

## Requisitos

- Delphi com suporte a VCL.
- FireDAC.
- Driver FireDAC compatavel com o banco usado pela aplicacao.

O projeto atual referencia componentes FireDAC para Firebird/InterBase.

## Como Abrir

1. Abra `BasicORM.dproj` no Delphi.
2. Compile o projeto em `Win32` ou ajuste a plataforma conforme necessario.
3. Configure a conexao FireDAC antes de executar rotinas que acessam banco de dados.

## Observacoes de Desenvolvimento

- O projeto usa RTTI, entao as propriedades precisam estar publicadas de forma acessivel ao mecanismo de reflection usado.
- Os arquivos em `test/` servem como exemplo manual do mapeamento.
- O arquivo `.gitignore` ignora saidas de build como `bin/` e `lib/`.

## Licenca

Licenca ainda nao definida.

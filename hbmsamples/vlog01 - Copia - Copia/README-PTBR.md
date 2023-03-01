# README #

## vlog ##

A classe vlog é responsável por gerar os logs do sistema.

## Como funcionam os logs do sistema

Primeiramente configure o nível dos logs do sistema. O sistema possui 4 níveis de logs:

1. Logs de informação (info) : gravam informações que, não necessariamente, são notificações de erros. 
1. Logs de aviso (warning) : gravam informações que são suspeitas e que podem acarretar erros.
1. Logs de erro (error) : gravam informações que são erros.
1. Logs que gravam situações que envolvem saída do sistema. Erros fatais. Esses logs são gerados automaticamente.

Para configurar o nível dos logs faça :

````
CONFIG LOG LEVEL <Level>
````

Onde \<Level> é o nível do log, e pode assumir os seguintes valores :

1. INFO : Logs de informação
1. WARNING : Logs de warning
1. ERROR : Logs de erro
1. FATAL : Logs de erros fatais

### Sobre os níveis das mensagens 

* o nível INFO irá gravar também os níveis WARNING, ERROR e FATAL.
* o nível WARNING irá gravar também o nível ERROR e FATAL.
* o nível ERROR irá gravar também o nível FATAL.
* o nível FATAL irá gravar somente o nível FATAL.

Se CONFIG LOG LEVEL não for informado, o nível padrão é o FATAL. 

Importante : o nível FATAL é gravado automaticamente pelo sistema após um erro acontecer. Esse nível não pode ser omitido. Ele é gerado pelo sistema de erros padrão logo após um erro fatal acontecer.

### Gerando o log

O log é gerado através do comando 

````
LOG "Texto a ser gravado" <Level>
````

Por exemplo:
````
LOG "Arquivo de clientes foi aberto com sucesso" INFO
````

### Nota importante

O comando LOG só será executado corresponder ao CONFIG LOG LEVEL apropriado, por exemplo:

````
CONFIG LOG LEVEL ERROR
LOG "Arquivo de clientes foi aberto com sucesso" INFO
````

A informação "Arquivo de clientes foi aberto com sucesso" não será gravada no log do sistema porque o CONFIG LOG LEVEL está setado para ERROR.

Já o exemplo a seguir irá gravar todos os logs porque está no nível mais permissivo : INFO.

````
CONFIG LOG LEVEL INFO
LOG "Arquivo de clientes foi aberto com sucesso" INFO
LOG "O valor gerado está muito acima da média dos últimos meses" WARNING
LOG "O servidor está inacessível" ERROR
````

Finalmente, o exemplo abaixo irá gravar apenas WARNING e ERROR.

````
CONFIG LOG LEVEL WARNING
LOG "Arquivo de clientes foi aberto com sucesso" INFO
LOG "O valor gerado está muito acima da média dos últimos meses" WARNING
LOG "O servidor está inacessível" ERROR
````

### Qual é a nomenclatura padrão de um arquivo de log ?

O arquivo de log recebe a seguinte nomenclatura : ANO + MES + DIA seguido da extenção `.log`.

Por exemplo: `20200320.log` equivale ao log do dia 20/Mar/2020.

## Como devo realizar as compilações das amostras ? ##

Compile os exemplos com o `hbmk2`

Por exemplo
````
hbmk2 vlog01 
````

### Breve descrição das amostras

1. vlog01 : mostra como obter as informações sobre as configurações do sistema de log através da classe VConfig.
1. vlog02 : `CONFIG LOG LEVEL` e `LOG`
1. vlog03 : `CONFIG LOG DISPLAY ON/OFF`
1. vlog04 : demonstra o uso da cláusula `UPDATE LAST MESSAGE` dentro de uma classe
1. vlog04err : exemplo de uso incorreto da cláusula `UPDATE LAST MESSAGE`
1. vlog05 : gerando uma mensagem com código de erro (cláusula CODE do comando LOG)
1. vlog06 : `LOG TEXT`
1. vlog07 : `LOG TEXT` com TAG personalizada
1. vlog08 : `LOG TEXT` enviando para um log não padrão (cláusula `TO FILE`)
1. vlog09 : `LOG GROUP`
1. vlog10 : Simulando um erro de execução com posterior gravação do erro no log padrão (Nível FATAL).

## Descrição dos comandos

### CONFIG LOG LEVEL

Configura o nível das mensagens a serem gravadas no log. Os valores são:

* `CONFIG LOG LEVEL FATAL` 
* `CONFIG LOG LEVEL ERROR`
* `CONFIG LOG LEVEL WARNING`
* `CONFIG LOG LEVEL INFO`

A explicação desses valores já foi feita no início desse documento.

### CONFIG LOG DISPLAY ON/OFF


* `CONFIG LOG DISPLAY ON` : ecoa os valores gravados no log para a tela também.
* `CONFIG LOG DISPLAY OFF` : não ecoa os valores para a tela. Esse é o padrão.


###  LOG

Comando responsável pela gravação do LOG no arquivo.

* O exemplo abaixo irá gravar a mensagem, caso o `CONFIG LOG LEVEL` permita.

````
LOG "Arquivo não foi aberto corretamente" ERROR
````

* O exemplo abaixo irá, além de gerar o log, enviar o conteúdo gravado para a variável cMessage.

````
LOG "Arquivo não foi aberto corretamente" ERROR TO cMessage
````

* O exemplo abaixo irá atualizar a última mensagem gerada através de ::setLastMessage. 

````
LOG "Arquivo não foi aberto corretamente" ERROR UPDATE LAST MESSAGE
````

Importante: Essa cláusula só pode ser usada dentro de uma classe, e o método `::setLastMessage` deve estar definido nessa classe. Todas as classes que começam com a letra `V` tem esse método definido. Caso você vá usar esse formato, lembre-se de herdar a sua classe de VObject, que é a classe que contém ::setLastMessage.

* O exemplo abaixo irá gravar a mensagem e irá adicionar um código de erro de sua responsabilidade.

````
LOG "Arquivo não foi aberto corretamente" ERROR CODE 123456
````

**Dica** : No VSCode, para gerar códigos únicos, você pode usar a extensão "Insert Date String" de "Jakub Synowiec". Após instalar :

* Vá em configurações e retire os "-" e ":" da máscara.
* Para testar tecle  Ctrl+Shift+I. a extensão irá inserir um timestamp, conforme abaixo :

````
20210616183438
````

**Dica-2:** Use o utilitário codebug para cadastrar seus códigos de erros

###  LOG TEXT

Esse comando é muito pouco usado. Ele vai gerar um log que será gerado independente do valor de CONFIG LOG LEVEL. 

````
LOG TEXT "Serei escrito, independente de LOG LEVEL"
````

O exemplo abaixo envia a mensagem para o arquivo de log definido em `TO FILE`.

````
LOG TEXT "Serei escrito, independente de LOG LEVEL" TO FILE NovoLog.log
````

O exemplo abaixo atribui o valor "ESPECIAL" para a tag de classificação. A tag de classificação é um valor entre colchetes que inicia a linha do log. 

````
LOG TEXT "Serei escrito, independente de LOG LEVEL" TAG "ESPECIAL"
````

###  LOG GROUP

É usado para gerar marcas especiais no seu arquivo de log. É útil para marcar o inicio e o final de um processamento. Por exemplo:

````
LOG GROUP "Baixa de notas fiscais"

Comandos de baixa de nota fiscal
Logs 
etc.

LOG GROUP END // Aqui termina a baixa de notas fiscais
````


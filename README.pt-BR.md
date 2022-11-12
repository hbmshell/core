# HbmShell

O poder do Harbour + A força do Shell Script

## Introdução

O objetivo desse repositório é guardar exemplos de códigos feitos em `hbmshell`. O aplicativo `hbmshell` é um freeware que pode ser baixado e usado livremente e sem restrições (na raiz desse repositório temos as versões mais recentes). Ele foi desenvolvido com o objetivo de tornar mais fácil o aprendizado da linguagem Harbour, já que ele é de fácil instalação e não requer muitos conhecimentos em programação. Maiores detalhes sobre a linguagem Harbour você pode encontrar [aqui](https://en.wikipedia.org/wiki/Harbour_(programming_language)) e [aqui](https://harbour.github.io/). 

## 🚀 Começando

O que você precisa para instalar o `hbmshell` ?

O `hbmshell` é um executável que já vem pronto para uso, portanto não necessita de um instalador. Contudo, existem pequenas diferenças de acordo com o sistema operacional utilizado.

### Se você é usuário Linux :

Baixe o binário clicando [aqui](bin/linux/). Esse binário foi compilado no Ubuntu 20.

````
chmod +x hbmshell
chmod +x hello.prg
./hello.prg 
````

Note que a primeira linha do seu script deve fazer referencia ao executável :
```
#!/caminho/para/o/diretorio/hbmshell
```

Você também pode executar assim:

````
./hbmshell hello.prg
````


### Se você é usuário Windows :

Baixe o binário clicando [aqui](bin/windows/). Esse binário foi compilado no Windows 11.

````
hbmshell.exe hello.prg
````


## 📰 Hello World

````
#!/caminho/para/o/diretorio/hbmshell
PROCEDURE HB_Main
    
    ? "Hello World"
    
RETURN
````

Comentários

1. A primeira linha é uma referência ao executável (ela é obrigatória caso você esteja usando o Linux e deseje executar o script diretamente: `./myscript.prg`).
1. Agora vem o programa principal.

## 📋 Referenciando arquivos (.ch) 

O `hbmshell` já vem com alguns arquivos (.ch) embutidos no próprio executável, portanto você não precisará fazer referencia a eles nos seus programas. São eles :

> * inkey.ch
> * button.ch
> * hbclass.ch
> * achoice.ch
> * dbedit.ch
> * dbstruct.ch
> * directry.ch
> * fileio.ch
> * set.ch
> * setcurs.ch
> * tbrowse.ch
> * error.ch
> * simpleio.ch
> * hbver.ch
> * dbinfo.ch
> * hbdyn.ch // Windows  
> * hbgtinfo.ch // Caso use wvt (Windows)
> * Cabeçalhos da hmg // Caso use hmg (Windows)

Portanto, se você é um iniciante, você pode pular o restante dessa seção, já que todos os arquivos cabeçalhos mais importantes já são inseridos automaticamente.

Se, mesmo assim, você precisar referenciar seus arquivos (.ch) existem três formas : 

* Forma 1 : copie todos os cabeçalhos para o diretório `/usr/local/include/harbour` ou `/usr/local/include/hbmediator`. O `hbmshell` irá procurar os cabeçalhos nesses diretórios.
* Forma 2 : Crie as variáveis de ambiente apontando para o local desejado. Você pode criar até duas variáveis com os seguintes nomes : `SISTEMAS_PATH_TO_INCLUDE` e `SISTEMAS_PATH_TO_INCLUDE_HRB`. Como sugestão: a primeira variável (`SISTEMAS_PATH_TO_INCLUDE`) pode apontar para o diretório include do `harbour` e a segunda  (`SISTEMAS_PATH_TO_INCLUDE_HRB`) pode apontar para o diretório  include do `hbmshell`.

📎Usuários linux :
```
export SISTEMAS_PATH_TO_INCLUDE=/workspace/hbmshell/include/harbour
export SISTEMAS_PATH_TO_INCLUDE_HRB=/workspace/hbmshell/include/hbmediator
```

📎Usuários Windows :
```
set SISTEMAS_PATH_TO_INCLUDE=C:\workspace\hbmshell\include\harbour
set SISTEMAS_PATH_TO_INCLUDE_HRB=C:\workspace\hbmshell\include\hbmediator
```

* Forma 3 : Informe os diretórios includes no próprio script, no seu cabeçalho. O `hbmshell` irá interpretar essas linhas como diretivas de compilação. Faça isso através da flag `-I`. 

```
#!/caminho/para/o/diretorio/hbmshell
//-I/caminho/para/o/include01
//-I/caminho/para/o/include02
//-IC:\caminho\para\o\include01\windows

```

>Caso seu script seja executado de um local conhecido você pode usar caminhos relativos. Por exemplo: `-I./include`

  

## 🔧 Formas de execução

A forma padrão de execução de scripts, já descrita acima, usa o seguinte formato :

``
hbmshell meuscript.prg
``

### Usando Gets e outros controles 

Caso você necessite dos controles em modo TUI (Text User Interface) use o parâmtro `--dialog` conforme abaixo :

````
hbmshell meuscript.prg --dialog tui
````

Alguns exemplos de controles TUI: GET, SAY, Achoice(), TBrowse(), DbEdit(), etc.

### Usando a lib WVT (somente windows)

A lib wvt permite gerar um aplicativo em uma nova janela, com suporte a mouse. Nesse caso faça:


````
hbmshell meuscript.prg --dialog wvt
````


### Usando a lib HMG (somente windows)

A lib HMG permite gerar um aplicativo usando os controles do Windows. Nesse caso faça:

````
hbmshell meuscript.prg --dialog hmg
````

### Modo --run 

O modo `--run` executa o script informado normalmente. A diferença aqui é que se o script não for encontrado na pasta informada por `--run` ele irá buscar nas subpastas até achar o script.

Exemplo:
```
hbmshell --run script.prg --run-path c:\temp
```
No exemplo acima, meuscript.prg será buscado na pasta `c:\temp`. Se não encontrar irá buscar nas subpastas, por exemplo:

````
c:\temp
c:\temp\figuras
c:\temp\bin
c:\temp\outros
````

### Modo servidor

Para gerar um script remoto que fica "escutando" em uma determinada porta e é executado mediante protocolo http faça :

````
hbmshell meuscript.prg --server --port 8081
````

Se `--port` for omitida, o valor default é 8080.


### Modo site

O modo site executa todo o conteúdo de uma pasta mediante o protocolo http

````
hbmshell  --site pasta_do_site --port 8081
````

Vai iniciar um servidor web exindo o conteúdo da pasta informada. A página padrão é `index.html`

````
hbmshell  --site pasta_do_site --site-index start.html --port 8081
````
Nesse exemplo `--site-index` mudou a página padrão para start.html. 

* Nota: página padrão é aquela que é exibida caso nenhuma outra seja informada. Por exemplo:

````
http://localhost:8081/
````

### Modo site cgi

Esse modo é uma extensão do modo anterior. Ele permite a execução de scripts contidos em uma pasta informada.

````
hbmshell  --site pasta_do_site --cgi-bin pasta
````

Nesse caso o sistema irá executar os scripts (.prg) contidos na pasta informada. Independente do nome da pasta, ela será referenciada virtualmente através do nome "cgi-bin". Por exemplo

````
http://localhost:8081/cgi-bin/meuscript.prg
````

Você pode mudar o nome da pasta virtual através do parâmetro `cgi-bin-alias`. Por exemplo:

````
hbmshell  --site pasta_do_site --cgi-bin pasta --cgi-bin-alias "/scripts"
````

Nesse caso os scripts (.prg) serão acessados assim :

````
http://localhost:8081/scripts/meuscript.prg
````

## 🔰Outros parâmetros de linha de comando

### --delay

Gera uma espera (em X segundos) antes da execução do script. Útil quando estamos executando o `hbmshell` recebendo dados de um pipe, cujo programa anterior demora para retornar os valores. Por exemplo:

````
wget https://lazy | hbmshell script.prg --delay 10
````

### --pause-after

Gera uma pausa indefinida após a execução do script. 


### --gencode

Gera um script básico para você não começar a programar do zero. 

````
hbmshell --gencode script.prg
````

### --debug-hbm

Gera informações de depuração na saída do script.

### --codepage

Define o codepage do seu script. O default é `UTF8`.

````
hbmshell script.prg --codepage PTISO
````

Valores válidos :

* UTF8 : Default
* PTISO
* PT850


### --download

Baixa um arquivo

````
hbmshell --download http://url
````


## 🔰Exemplos

Esses e outros exemplos podem ser encontrados na pasta `samples` desse projeto.

### Para conhecer a linguagem Harbour.

* [Hello World](hello.prg)
* [O mínimo](samples/basic/00hello/)
* [Strings](samples/basic/01strings/)
* [Operadores](samples/basic/04oper/)
* [O pré-processador](samples/basic/05preprocess/)
* [Diretivas](samples/basic/06compile/)
* [Funções matemáticas](samples/basic/07math/)
* [Loops](samples/basic/08loop/)
* [Say e Get](samples/basic/09get/)
* [Variáveis](samples/basic/10var/)
* [Projetos com mais de um arquivo fonte](samples/basic/11twoFiles/)
* [Arquivos binários em tempo de compilação](samples/basic/12stream/)
* [Macro-substituições](samples/basic/13macro/)
* [Shell bash](samples/basic/14bash/)
* [Arrays](samples/basic/15array/)
* [Hash](samples/basic/16hash/)
* [Ponteiros](samples/basic/17pointers/)
* [Arquivos textos em tempo de compilação](samples/basic/18pragma/)
* [Begin sequence - Tratamento de erros](samples/basic/19beginsequence/)
* [Arquivos DBFs](samples/basic/20dbf/)

## 🛠️ Construído com


* [Harbour](https://harbour.github.io/) - Compilador/Tradutor Harbour.
* [Código fonte do Harbour](https://github.com/harbour/core/) - Com instruções claras e precisas para você gerar o Harbour.


## Links interessantes

* [Harbour documentação oficial](https://harbour.github.io/doc/) 
* [Lista de funções](https://github.com/Petewg/harbour-list)
* [Documentação Juan Luis Gamero](https://github.com/zgamero/sandbox/wiki)
* [Harbour for begginers](https://www.kresin.ru/en/hrbfaq.html)
* [Grupo oficial](https://groups.google.com/g/harbour-users/) - Perguntas somente em inglês.
* [Linguagem Clipper](https://linguagemclipper.com.br) 
* [Fórum Clipper On-Line](https://www.pctoledo.com.br/forum) 
* [Harbour A-Z](https://github.com/Petewg/harbour-core/wiki/hb_A#wiki-pages-box)
* [Harbour manual for beginners](https://www.kresin.ru/en/hrbfaq.html) 
* [HMG Fórum](https://hmgforum.com/) 
* [Viva Clipper](https://vivaclipper.wordpress.com/)


## Utilitários diversos

* [Base64 encode](https://www.base64encode.org/)


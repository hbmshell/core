# Hbmshell cookbook


## 🚀 Basic

### Variables

1. [How to attrib value to variable (Dbase Legacy mode)](./attrib01/main.prg)
1. [How to attrib value to variable (Harbour mode)](./attrib02/main.prg)
1. [How to determine if a given name is a PUBLIC or PRIVATE memory variable](./var/main.prg)

### Data types

1. [How to convert a string to number](./convert01/main.prg)
1. [How to convert a number to string](./convert02/main.prg)
1. [How to place leading zeros in a string with numerical values](./convert03/main.prg)
1. [How to convert a date to string](./convert04/main.prg)

### Strings

1. [How to extract blank spaces around the string](./alltrim/main.prg)
1. [How to select chars inside string](./CharOnly/main.prg)
1. [How to convert string delimited in a array](./explode/main.prg)
1. [How to get caracter 'N' in string delimited by 'K'](./tokenget/main.prg)
1. [How to search and replace word inside a string](./rtf/main.prg)

### Comments

1. [How to comment your code](./comment/main.prg)

### Arrays

1. [How to declare, initialize and fill arrays](./array01/main.prg)
1. [How to iterate in array (an example with for loop)](./array02/main.prg)
1. [Create an array dinamically (with ARRAY() function)](./array03/main.prg)
1. [Create an array dinamically (with AADD() function)](./array04/main.prg)
1. [Whats difference between arrays initializate in line and arrays initializates in differents lines](./array05/main.prg)
1. [How to compare two arrays](./array06/main.prg)
1. [Arrays are always passed by reference](./array07/main.prg)
1. [Array element are permanent changed inside functions](./array08/main.prg)
1. [An array element passed to function is equal to any variable](./array09/main.prg)
1. [Returning arrays from functions](./array10/main.prg)
1. [How to iterate in array (an example with foreach)](./array11/main.prg)
1. [How to iterate in array (an example with foreach) - Pay atention to extra loop properties](./array12/main.prg)
1. [How to iterate in array (an example with foreach) - Pay atention to extra loop properties](./array13/main.prg)
1. [How to use change array size](./array14/main.prg)
1. [How to convert string delimited in a array](./explode/main.prg)

### Hashs

1. [How to search content in hash (like a Ascan)](./hscan/main.prg)

### Codeblock

1. [Did you know that an element inside a codeblock is created in compiled time, but is avaliated only in runtime.](./bloco01/main.prg)
1. [Did you know that an element inside a codeblock is created in compiled time, but is avaliated only in runtime (Part II).](./bloco02/main.prg)
1. [How to create a extended codeblock.](./bloco03/main.prg)
1. [Whats difference between standard codeblock and extended codeblock.](./bloco04/main.prg)
1. [How to execute a routine inside extended codeblock.](./bloco05/main.prg)
1. [How to create a codeblock in runtime.](./bloco06/main.prg)

### Pre-compiler

1. [how to declare variable in compile time](./define/main.prg)
1. [How to execute code according platform](./define_platform/main.prg)
1. [How to create pseudo command according variable defined in compile time (variable is in external file .ch)](./define2/main.prg)
1. [How to create pseudo command according variable defined in compile time (variable is in external file .ch - detail: this file is not in O.S. PATH)](./define3/main.prg)
1. [How to see content file text](./pragma/main.prg)
1. [How to copy a binary file](./stream/main.prg)
1. [How to create your own commands](./command/main.prg)


### Random

1. [How to generate random number without repetitions](./sorteio/main.prg)

### Error control

1. [How to change my error controller](./errorControl01/main.prg)
1. [How to create error control standard](./errorControl02/main.prg)

### Run time system

1. [How to execute a code inside variable](./compileFromBuff01/main.prg)

### OOP

1. [How to create a simple class](./oop01/main.prg)

### Pointer

1. [How to call a function through a pointer](./pointer/main.prg)

### RegExp

1. [How to match any caracter in regexp](./regexp_DOT/main.prg)
1. [How to match many caracters in regexp](./regexp_LIST/main.prg)
1. [How to negate specific word in regex](./regexp_DENYLIST/main.prg)
1. [How to find one or more characters regardless of the previous character](./regexp_Optional/main.prg)
1. [How to find one or more characters that can appear in any quantity](./regexp_AnyQuant/main.prg)

### Codepage

1. [How to list all codepages availables](./cdpList/main.prg)
1. [Warning: order change after switch current codepage to another](./cdpSelect/main.prg)


## 📟 TUI

### Basic 

1. [Accept command](./accept/main.prg)
1. [How to draw a rectangle with @ BOX command](./arrobaBox/main.prg)

### Achoice

1. [Achoice basic](./achoice01/main.prg)
1. [Achoice UDF](./achoice02/main.prg)

### Menus

1. [How to generate menu](./menu/main.prg)

### Get 

1. [Basic example with GET command](./get01/main.prg)
1. [How to display message in get command](./get02/main.prg)
1. [How to use RANGE clause in get command](./get03/main.prg)
1. [How to use VALID clause in get command](./get04/main.prg)
1. [How to use WHEN clause in get command](./get05/main.prg)
1. [How to use WHEN clause in get command (Edit control)](./get06/main.prg)
1. [How to use WHEN and VALID clauses in get command (Edit control)](./get07/main.prg)
1. [Picture examples](./get08/main.prg)
1. [Picture examples (With message)](./get09/main.prg)
1. [Checkbox example](./get10/main.prg)
1. [Listbox example](./get11/main.prg)
1. [Pushbutton example](./get12/main.prg)
1. [Radiobutton example](./get13/main.prg)
1. [Get with TBrowse example](./get14/main.prg)
1. [Get with Set Delimiters example](./get15/main.prg)
1. [Clear gets example](./get16/main.prg)
1. [Set intensity example](./get17/main.prg)
1. [Listbox example](./get18/main.prg)
1. [Checkbox example](./get19/main.prg)
1. [Listbox example](./get20/main.prg)
1. [Validation tip](./getvalid/demo.prg)
1. [Examplo with cargo() attribute](./cargo/main.prg)

### Colors

1. [How to simulate an old monitor's color](./cor01/main.prg)
1. [How to create a form with many colors](./cor02/main.prg)
1. [How to configure MENU TO colors](./cor03/main.prg)
1. [How to store old color to recover](./cor04/main.prg)


### TBrowseNew

1. [How to see text file in TBrowse](./tbrowsetext/demo.prg) (With FT Functions)
1. [How to browse an array using TBrowse](./arrayTBrw/main.prg)

## 🎨 Images

### Code bars

1. [How to create QRCode](./QRCode/main.prg)

## 📖 Database

### DBF

1. [How to create a DBF file](./dbcreate/main.prg)
1. [How to generate DBF in memory](./DBFInMem/main.prg)
1. [How to create DBF with autoincrement field](./dbcreateAutoNum/main.prg)


### MySQL

1. [How to connect MySQL Server (with classes)](./MySQLConnect/main.prg)

### SQLite

1. [How to create a SQLite database](./sqlite01/main.prg)
1. [How to insert records in SQLite database](./sqlite02/main.prg)

## 💻 System operation

### Info

1. [How to get a O.S. name](./OSInfo/main.prg)

### Hardware

1. [How to detect Discs (HD,SSD,USB)](./USBIdentify/main.prg)

### Users

1. [How to get username](./username/main.prg)

### Run external program

1. [How to execute a file (new process is generated)](./run01/main.prg)


### Network

1. [How to get a IP address (and MAC)](./ip/main.prg)


## 📂 File

### Low-level

1. [How to create  low level file](./lowlevel01/main.prg)
1. [How to create  low level file (Reead only)](./lowlevel02/main.prg)
1. [How to create  low level file (Hidden)](./lowlevel03/main.prg)
1. [How to generate log](./log/main.prg)
1. [How to iterate in text file](./FUse/main.prg)

### Directory functions

1. [How to get full PATH where the executable is located](./directory/main.prg)
1. [How to verify if directory exists](./directory2/main.prg)
1. [How to convert PATH separator to format according Operational System](./directory3/main.prg)

### File functions

1. [How to extract informations about Path, Name and Extension from a string contain full filename](./file/main.prg)
1. [How to extract informations about Path, Name and Extension from a string contain full filename (II)](./file2/main.prg)
1. [How to merge strings to create a full filename](./file3/main.prg)
1. [How to save a file after changeit](./rtf/main.prg)

### Erasing files

1. [How to erase file](./erase/main.prg)
1. [How to erase multiples files](./erase2/main.prg)

### INI Files

1. [How to create a ini file from hash](./ini1/main.prg)
1. [How to create a ini string from hash](./ini2/main.prg)

### Json Files

1. [How to convert a hash to string in Json format](./json01/main.prg)


### CSV Files

1. [How to import CSV File to array](./csv01/main.prg)
1. [How to import CSV File to array and display fields one by one](./csv02/main.prg)

## 🌎 Internet

1. [How to get info from webservice (TIP/http)](./cep/demo.prg)
1. [How to send email (Gmail/Curl)](./email/main.prg)

## 🪟 Windows

### API

1. [How to open document from file type](./WinOpenURL/main.prg)
1. [How to list devices in Windows](./WinListDevices/main.prg)
1. [How to download web content](./WinDownload/main.prg)
1. [How to get time and date from web](./WinGetTime/main.prg)
1. [How to get win version, architecture and build](./WinVersion/main.prg)

### OLE


#### MS Excel

1. [Does computer support excel ?](./WinExcel1/main.prg)
1. [Hello world in Excel](./WinExcel2/main.prg)
1. [How to enumerate my sheets](./WinExcel3/main.prg)
1. [How to configure font](./WinExcel4/main.prg)
1. [DBF to Excel](./WinExcel5/main.prg)
1. [DBF to Excel (How to autofit)](./WinExcel6/main.prg)
1. [DBF to Excel (How to autofit) + Bold](./WinExcel7/main.prg)
1. [How to use a Template to my sheets](./WinExcel8/main.prg)

### HMG

#### HMG - Without a IDE

1. [How to create a Hello World with HMG](./HMGTut01/main.prg)
1. [How to change a control propertie](./HMGTut02/main.prg)
1. [How to create a label](./HMGTut03/main.prg)
1. [How to use a text edit control](./HMGTut04/main.prg)
1. [How to use a check box control](./HMGTut05/main.prg)
1. [How to use a radio button control](./HMGTut06/main.prg)
1. [How to use a list box control](./HMGTut07/main.prg)
1. [How to use a combo box control](./HMGTut08/main.prg)
1. [How to use a button control](./HMGTut09/main.prg)
1. [How to use a image button control](./HMGTut10/main.prg)
1. [How to use a check button control](./HMGTut11/main.prg) ---- Bug
1. [How to use a datepicker control](./HMGTut12/main.prg)
1. [How to use a editbox control](./HMGTut13/main.prg)
1. [How to use a image control](./HMGTut14/main.prg)
1. [How to use a progressbar control](./HMGTut15/main.prg)
1. [How to use a spinner control](./HMGTut16/main.prg)
1. [How to use a tab control](./HMGTut17/main.prg)
1. [How to use a tool bar control](./HMGTut18/main.prg)
1. [How to use a status bar control](./HMGTut19/main.prg)
1. [How to create a grid](./HMGTut20/main.prg)
1. [How to create data bound (like a Delphi DbNavigator)](./HMGTut21/main.prg)
1. [How to create a split box](./HMGTut22/main.prg)
1. [How to create a getfile window](./HMGGetFile/main.prg)
1. [How to create a webview (IE Explorer Control)](./HMGWebView/main.prg)
1. [How to create a Internet Explorer instance from ActiveX Control](./HMG_ActiveX02/main.prg)
1. [How to create a grid with pictures in buttons](./HMG_GridButtons/main.prg)
1. [How to insert a resource in program](./HMG_Resource/Main.Prg) ---- Bug
1. [How to create a Hyperlink](./HMG_HyperLink/main.prg) ----- Bug
1. [How to get a parent window name](./HMG_GetParent/)
1. [How to create a event in form](./HMG_Event/main.prg)
1. [How to select printer](./HMG_Printer/main.prg)
1. [How to enable/disable button in runtime mode](./HMG_Button01/main.prg)
1. [How to create a wait window](./HMG_WaitWindow/main.prg)
1. [How to create a wait window (II)](./HMG_WaitWindow02/main.prg)
1. [How to create a timer](./HMG_Timer/main.prg)
1. [How to create a timer (II)](./HMG_Timer/main.prg)
1. [How to print to PDF](./HMG_Print_to_PDF/main.prg)
1. [How to load all windows in memory](./HMGNOAutoRelease01/main.prg)
1. [How to load all windows in memory II](./HMGNOAutoRelease02/main.prg)

#### HMG - With IDE

1. [How to create a simple program in HMG](./HMGHelloIDE/)
1. [How to create a login screen](./HMGLogin/)
1. [How to create a simple menu](./HMGMenu/)
1. [How to create a Grid and Button](./HMG_Grid01/)
1. [How to associate an action a Button and send result to Grid](./HMG_Grid02/)
1. [How to create a simple form](./HMG_Form/)
1. [How to open form from grid after double click in cell](./HMG_GridOpenForm/)
1. [How to create a Internet Explorer instance from ActiveX Control](./HMG_ActiveX01/)
1. [How to load all windows in memory III](./HMGNOAutoRelease03/main.prg)
1. [How to load all windows in memory IV](./HMGNOAutoRelease04/main.prg)


### Database

1. [How to open connection in MariaDb using ADO](./WinMariaDbADO/main.prg)
1. [How to execute a SQL statement in MSAccess using ADO](./WinMSAccessADO/main.prg)

### WVG

1. [How to create menu](./MenuWVG/main.prg)


### HMG

If you want, open project with HMG Ide to change forms. Don't compile, just call main.bat to execute program.

1. [How to create login form](./HMGLogin/Main.Prg)

## 🔒 Security

### Cryptography

1. [How to encrypt string with hb_crypt](./crypt01/main.prg)
1. [How to encrypt string with hb_crypt (Part II)](./crypt02/main.prg)

## 📑 Corporative Information System

### Finance

1. [How to generate credit card payment installments](./parcelas/main.prg)
1. [How to generate plots without float point](./plots/main.prg)


### Integration

1. [How to send string from SSH Server to Putty client](./putty/main.prg)


### Brazilian documents

1. [Como validar um titulo de eleitor](./TituloEleitor/main.prg)
1. [Como consultar o CEP on-line](./cep/demo.prg)


## Examples

### Games and Puzzles

1. [The 15 Puzzle](./quinze/quinze.prg)







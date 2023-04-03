/*
https://www.hmgforum.com/viewtopic.php?t=117

O 5o par�metro de getfile() � o valor da vari�vel de sistema 'diret�rio atual'. 
Se voc� quiser alterar o valor da vari�vel do sistema para esse diret�rio espec�fico ap�s a sele��o do usu�rio, use .t. 
caso contr�rio, se for apenas para selecionar o arquivo e a vari�vel do diret�rio atual estiver intacta, voc� deve usar .f.
*/
#include <hmg.ch>
function main

define window sample at 0,0 width 500 height 200 main

   define button get1
      row 10
	  col 10
	  caption "GetFile with 5th parameter equal .t."
      width 400
	  action getfilewithtrue()
   end button
   define button get2
      row 40
	  col 10
      width 400
	  caption "GetFile with 5th parameter equal .f."
	  action getfilewithfalse()
   end button 
end window
sample.center
sample.activate
return nil

function getfilewithtrue
g := getfile({ {'All Files','*.*'} } , 'Select a File' , 'c:\' , .f. , .t.)
 
msginfo(getcurrentfolder())
return nil

function getfilewithfalse
g := getfile({ {'All Files','*.*'} } , 'Select a File' , 'c:\' , .f. , .f.)
 
msginfo(getcurrentfolder())

return nil
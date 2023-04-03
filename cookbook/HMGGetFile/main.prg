/*
https://www.hmgforum.com/viewtopic.php?t=117

O 5o parâmetro de getfile() é o valor da variável de sistema 'diretório atual'. 
Se você quiser alterar o valor da variável do sistema para esse diretório específico após a seleção do usuário, use .t. 
caso contrário, se for apenas para selecionar o arquivo e a variável do diretório atual estiver intacta, você deve usar .f.
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
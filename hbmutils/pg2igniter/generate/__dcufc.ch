/*
 * Importante
 * Renomeie esse arquivo para dcufc.ch
 * Copie o arquivo renomeado para a pasta SISTEMAS_PATH_TO_INCLUDE
 * copy dcufc.ch %SISTEMAS_PATH_TO_INCLUDE%
 * cp dcufc.ch $SISTEMAS_PATH_TO_INCLUDE
 *
 * Ou então copie para a pasta onde está a aplicação
 *
 */

#define __DATABASE_NAME "dcufc"
#define __DATABASE_IP "localhost"
#define __DATABASE_PORT "5432"
#define __DATABASE_USR "dcufc"
#define __DATABASE_PWD "m79opx" 

#command DATABASE <oObj> =>  <oObj> := VPostgreSQL():New()
#command <oObj>:Connect() =>  <oObj>:SetDatabaseName( __DATABASE_NAME );;
                            <oObj>:SetDatabaseIP( __DATABASE_IP);;
                            <oObj>:SetDatabasePort(__DATABASE_PORT);;
                            <oObj>:SetDatabaseUsr(__DATABASE_USR);;
                            <oObj>:SetDatabasePwd(__DATABASE_PWD)

#define CONNECTION_OK 0
#define PGRES_COMMAND_OK 0
#xtranslate CONNECT_ERROR_MESSAGE => SUBSTR( oObj:GetLastMessage() , 1, AT( "Is the server running" , oObj:GetLastMessage() )-1 )




                            

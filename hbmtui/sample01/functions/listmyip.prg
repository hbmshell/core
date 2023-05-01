#include "hbsocket.ch"
FUNCTION ListMyIP()
LOCAL aIFace
LOCAL aIp := {}

FOR EACH aIFace IN hb_socketGetIFaces( , .t. )
    AADD( aIp , aIFace[ HB_SOCKET_IFINFO_ADDR ] )
    //" MAC:", aIFace[ HB_SOCKET_IFINFO_HWADDR ]
NEXT

RETURN aIp
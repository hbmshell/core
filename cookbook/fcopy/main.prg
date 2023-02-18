//#include "Fileio.ch"
#define BUFFER_SIZE  2^16    // 64 Kb
 
PROCEDURE Main
       ? FCopy( "OLDFILE.DOC", "NEWFILE.DOC" )
RETURN
 
FUNCTION FCopy( cSourceFile, cTargetFile )
      LOCAL nSource, nTarget, cBuffer, nBytes
 
      IF ( nSource := FOpen( cSourceFile, FO_READ ) ) == -1
         ? "Can not open Source",cSourceFile
       ELSEIF ( nTarget := FCreate( cTargetFile, FC_NORMAL ) ) == -1
          FClose( nSource )
         ? "can not create Target", cTargetFile
       ENDIF
// need to define "buffer"    
      cBuffer := Space( BUFFER_SIZE )
      nBytes  := BUFFER_SIZE
 
      DO WHILE FError() == 0 .AND. nBytes > 0
         nBytes := FRead( nSource, @cBuffer, BUFFER_SIZE )
         FWrite( nTarget, Left(cBuffer, nBytes) )
      ENDDO
 
      FClose( nSource )
      FClose( nTarget )
 
RETURN FError()

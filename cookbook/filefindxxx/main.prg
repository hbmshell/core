//https://vivaclipper.wordpress.com/2014/03/01/filefindxxxx/
/*
FileFindXxxx functions provides a set of info on a set of file.

Calling first FileFindFirst() build an internal data structure ( probably an array like returned by Directory() ). 
And then calling other FileFindXxxx functions returns individual file info for last file found.
*/
PROCEDURE Main

LOCAL pFFInfo
         LOCAL nFileNo := 0
         LOCAL lContinue := FileFindFirst( '*.*', @pFFInfo )

         WHIL lContinue
            ? PAD( ++nFileNo, 3),;
              PAD( FileFindName( pFFInfo ), 23 ),;
                   FileFindAttr( pFFInfo ),;
                   FileFindSize( pFFInfo ),;
                   FileFindDate( pFFInfo ),;
                   FileFindTime( pFFInfo )
            lContinue := FileFindNext( pFFInfo )
         END


RETURN

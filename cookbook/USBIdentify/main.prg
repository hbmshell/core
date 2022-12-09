***************************

PROCEDURE MAIN()
    ***************************
    aDrives := {}
    FOR I:=1 TO 26
        cDrive := CHR(64+I)
        nTipo := DRIVETYPE(cDrive)
        DO CASE
           CASE nTipo = 0
                AADD(aDrives,cDrive+' '+'Disco RAM    ')
           CASE nTipo = 2
                IF !cDrive$'A|B'
                   IF VLJ_DISKREADY(cDrive,.F.)
                      AADD(aDrives,cDrive+' '+'Memoria USB  ')
                   ENDIF
                ENDIF
           CASE nTipo = 3
                AADD(aDrives,cDrive+' '+'Disco Duro   ')
           CASE nTipo = 4
                AADD(aDrives,cDrive+' '+'CD ROM       ')
           CASE nTipo = 5
                AADD(aDrives,cDrive+' '+'Unidad de Red')
           otherwise
    *           AADD(aDrives,cDrive+' '+'Desconocido  ')
        ENDCASE
    NEXT
    ASORT(aDrives,,,{|x,y|SUBSTR(x,3,5) < SUBSTR(y,3,5)})
    ? hb_ValToExp( aDrives )
    *** in array  ADrives  ---> usb units
    return
    
    
    /*
    * HB_ISREMOTEDISK( cDrv ) -> .T. if cDrv is a Remote Drive
    * HB_ISRAMDISK( cDrv ) -> .T. if cDrv is a RAM Disk
    * HB_ISHARDDISK( cDrv ) -> .T. if cDrv is a Hard Disk
    * HB_ISCDROM( cDrv ) -> .T. if cDrv is a CDROM
    * HB_ISDISKETTE( cDrv ) -> .T. if cDrv is a Floppy
    * HB_DISKREADY( cDrv ) -> .T. if cDrv is a Floppy and ready to be written
    * HB_DISKREADYW( cDrv ) -> same as HB_DISKREADY()
    */


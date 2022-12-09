/* Test.prg - For Win32 and CIM class.

This code is a basic sample.

j'en suis à :
https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-logicaldiskrootdirectory

# Test.hbp - Compilation de Test.EXE.
# -----------------------------------
#
# Nom du programme avec éventuellement son chemin.
#
-oTest
#
# Affiche tous les warnings.
#
-w3
#
# Ne fabrique pas l'exe si warning.
#
-es2
#
# Programme maître.
#
Test.prg
#
# Librairies : respecter l'ordre.
#
-lhbwin

*/

procedure main

    local oLocator
    local Item
    local Items
    local Propertie
    local Method
    local oWMI
    local i
    local n
    local tr
    local classe
    
    
    // Class name.
    
    //classe = "CIM_Chassis"  // Boîtier.
    //classe = "CIM_Chip"
    //classe = "CIM_DesktopMonitor"
    //classe = "CIM_DMA"
    //classe = "CIM_Display"  // Win32_DesktopMonitor
    //classe = "CIM_LogicalDevice"
    //classe = "CIM_Memory"
    //classe = "CIM_MemoryCapacity"
    //classe = "CIM_MemoryCheck"
    //classe = "CIM_MemoryMappedIO"
    //classe = "CIM_MemoryOnCard"
    //classe = "CIM_NonVolatileStorage"
    //classe = "CIM_OSVersionCheck"
    //classe = "CIM_PhysicalMedia"
    //classe = "CIM_PhysicalElement"
    //classe = "CIM_PhysicalMemory"
    //classe = "CIM_Process"
    //classe = "CIM_Processor"
    //classe = "CIM_Product"
    //classe = "CIM_Setting"  // Long à démarrer.
    //classe = "CIM_Thread"
    //classe = "CIM_USBDevice"
    //classe = "CIM_VideoController"
    
    //classe = "Win32_1394Controller"
    //classe = "Win32_1394ControllerDevice"
    //classe = "Win32_AutochkSetting"
    //classe = "Win32_BaseBoard" // Infos carte mère.
    //classe = "Win32_Battery"
    //classe = "Win32_BIOS"
    //classe = "Win32_Bus"
    //classe = "Win32_CacheMemory"
    //classe = "Win32_CDROMDrive"
    //classe = "Win32_CIMLogicalDeviceCIMDataFile"
    //classe = "Win32_ComputerSystem"
    //classe = "Win32_CurrentProbe"
    //classe = "Win32_DesktopMonitor"
    //classe = "Win32_DeviceChangeEvent"
    //classe = "Win32_DeviceMemoryAddress"
    //classe = "Win32_Directory"  // Long à démarrer.
    classe = "Win32_DiskDrive"
    //classe = "Win32_DiskPartition"
    //classe = "Win32_DisplayControllerConfiguration"
    //classe = "Win32_DMAChannel"
    //classe = "Win32_SystemEnclosure"
    //classe = "Win32_Fan"
    //classe = "Win32_FloppyController"
    //classe = "Win32_FloppyDrive"
    //classe = "Win32_HeatPipe"
    //classe = "Win32_IDEController"
    //classe = "Win32_IDEControllerDevice"
    //classe = "Win32_InfraredDevice"
    //classe = "Win32_IRQResource"
    //classe = "Win32_Keyboard"
    //classe = "Win32_LogicalDisk"
    //classe = "Win32_MotherboardDevice" // Pas grand'chose sur la carte, voir Win32_BaseBoard.
    //classe = "Win32_NetworkAdapter"
    //classe = "Win32_NetworkAdapterSetting" // Double : pas intéressant.
    
    //classe = "Win32_NetworkAdapterConfiguration" // Local IP
    //classe = "Win32_NetworkClient"
    //classe = "Win32_NetworkConnection" // Disques réseau.
    //classe = "Win32_NetworkLoginProfile"
    //classe = "Win32_NetworkProtocol"
    
    //classe = "Win32_NTEventLogFile" // Fichiers logs de Windows.
    //classe = "Win32_NTLogEvent" // Toutes les informations des log files.
    
       //C Log ... Win32_NTEventlogFile.Name="C:\\WINDOWS\\System32\\Winevt\\Logs\\Application.evtx"
       //C Record  Win32_NTLogEvent.Logfile="Application",RecordNumber=139547
    //classe = "Win32_NTLogEventLog" // 
    
       //C Computer  Win32_ComputerSystem.Name="BernardW8_PC"
       //C Record .. Win32_NTLogEvent.Logfile="Application",RecordNumber=139547
    //classe = "Win32_NTLogEventComputer"
    
       //C Record  Win32_NTLogEvent.Logfile="Application",RecordNumber=76033
       //C User .. Win32_UserAccount.Domain="LENOVO-PC15",Name="Bernard15"
    //classe = "Win32_NTLogEventUser" // 
    
    //classe = "Win32_OperatingSystem"
    //classe = "Win32_PerfFormattedData_TCPIP_NetworkInterface"
    //classe = "Win32_Printer"
    //classe = "Win32_PrinterDriver"
    //classe = "Win32_Process" // Liste des programmes.
    //classe = "Win32_Processor" // Informations du microprocesseur.
    //classe = "Win32_Refrigeration"
    //classe = "Win32_Service" // Liste des services.
    //classe = "Win32_TemperatureProbe"
    
    
       set date french
       set century on
       set( _SET_EOF, .F. ) // Not have <Ctrl-Z> at the end of file in set alte.
       // ANSI ( Windows ) and french language.
       request HB_LANG_FR
       request HB_CODEPAGE_FRWIN
       hb_cdpSelect( 'FRWIN' )
       hb_langSelect( 'FR' )
    
       setmode( 43, 80 )
       setcolor( "GR+/B" )
       @ 0, 0, maxrow(), maxcol() box space( 9 )
       setcolor( "W/B" )
    
    ferase( "_Result.txt" )
    set alte to _Result.txt
    set alte on
    ? "Harbour version :", Version()
    ?
    ? "Infos for class : " + classe
    ?
    oLocator  = WIN_OleCreateObject( "WbemScripting.SWbemLocator" )
    oWMI      = oLocator:ConnectServer( ".", "root\cimv2" )
    Items     = oWMI:ExecQuery( 'Select * from ' + classe )
    ? "Items count : " + ltrim( str( Items:count, 9, 0 ) )
    ?
    if Items:count < 1
       ? "No item for class : " + classe
    else
       i := 0
       for each Item in Items
          i ++
          ? replicate( "-", 99 ) + " " + ltrim( str( i, 9, 0 ) )
          n := 1
          for each Propertie in Item:Properties_
             if len( Propertie:Name ) > n
                n := len( Propertie:Name )
             endif
          endfor
          for each Propertie in Item:Properties_
             ? ValType( Propertie:Value ), Propertie:Name, replicate( ".", n - len( Propertie:Name ) ), ""
             do case
             case ValType( Propertie:Value ) == "A"
                ?? "Rows :", ltrim( str( len( Propertie:Value ), 9, 0 ) )
                for tr := 1 to len( Propertie:Value )
                   ? space( n + 3 ), Propertie:Value[ tr ]
                   if tr > 200
                      ? space( n + 3 ), "Il y a plus de 200 propriétés."
                      exit
                   endif
                endfor
             otherwise
                ??  Propertie:Value
             endcase
          endfor
          ? "  Methods :", ltrim( str( Item:Methods_:Count, 9, 0 ) )
          for each Method in Item:Methods_
             ? " ", Method:Name + "()"
          endfor
          if i > 200
             exit
          endif
       endfor
    endif
    ?
    Item      := nil
    Propertie := nil
    Method    := nil
    oLocator  := nil
    Items     := nil
    oWMI      := nil
    set alte off
    set alte to
    Wapi_ShellExecute( NIL, "open", "_Result.txt" )
    return
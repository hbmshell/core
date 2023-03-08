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
#include "inkey.ch"
procedure main

    local oLocator
    local Item
    local Items
    local Propertie
    local Method
    local oWMI
    local i
    local n := 1
    local tr
    local getlist := {}
    local classe
    local aClasse := {}
    
    
    // Class name.
    
    aadd( aClasse, "CIM_Chassis") 
    aadd( aClasse,  "CIM_Chip")
    aadd( aClasse,  "CIM_DesktopMonitor")
    aadd( aClasse,  "CIM_DMA")
    aadd( aClasse,  "CIM_Display") 
    aadd( aClasse,  "CIM_LogicalDevice")
    aadd( aClasse,  "CIM_Memory")
    aadd( aClasse,  "CIM_MemoryCapacity")
    aadd( aClasse,  "CIM_MemoryCheck")
    aadd( aClasse,  "CIM_MemoryMappedIO")
    aadd( aClasse,  "CIM_MemoryOnCard")
    aadd( aClasse,  "CIM_NonVolatileStorage")
    aadd( aClasse,  "CIM_OSVersionCheck")
    aadd( aClasse,  "CIM_PhysicalMedia")
    aadd( aClasse,  "CIM_PhysicalElement")
    aadd( aClasse,  "CIM_PhysicalMemory")
    aadd( aClasse,  "CIM_Process")
    aadd( aClasse,  "CIM_Processor")
    aadd( aClasse,  "CIM_Product")
    aadd( aClasse,  "CIM_Setting") 
    aadd( aClasse,  "CIM_Thread")
    aadd( aClasse,  "CIM_USBDevice")
    aadd( aClasse,  "CIM_VideoController")
    
    aadd( aClasse,  "Win32_1394Controller")
    aadd( aClasse,  "Win32_1394ControllerDevice")
    aadd( aClasse,  "Win32_AutochkSetting")
    aadd( aClasse,  "Win32_BaseBoard")
    aadd( aClasse,  "Win32_Battery")
    aadd( aClasse,  "Win32_BIOS")
    aadd( aClasse,  "Win32_Bus")
    aadd( aClasse,  "Win32_CacheMemory")
    aadd( aClasse,  "Win32_CDROMDrive")
    aadd( aClasse,  "Win32_CIMLogicalDeviceCIMDataFile")
    aadd( aClasse,  "Win32_ComputerSystem")
    aadd( aClasse,  "Win32_CurrentProbe")
    aadd( aClasse,  "Win32_DesktopMonitor")
    aadd( aClasse,  "Win32_DeviceChangeEvent")
    aadd( aClasse,  "Win32_DeviceMemoryAddress")
    aadd( aClasse,  "Win32_Directory")
    aadd( aClasse,  "Win32_DiskDrive")
    aadd( aClasse,  "Win32_DiskPartition")
    aadd( aClasse,  "Win32_DisplayControllerConfiguration")
    aadd( aClasse,  "Win32_DMAChannel")
    aadd( aClasse,  "Win32_SystemEnclosure")
    aadd( aClasse,  "Win32_Fan")
    aadd( aClasse,  "Win32_FloppyController")
    aadd( aClasse,  "Win32_FloppyDrive")
    aadd( aClasse,  "Win32_HeatPipe")
    aadd( aClasse,  "Win32_IDEController")
    aadd( aClasse,  "Win32_IDEControllerDevice")
    aadd( aClasse,  "Win32_InfraredDevice")
    aadd( aClasse,  "Win32_IRQResource")
    aadd( aClasse,  "Win32_Keyboard")
    aadd( aClasse,  "Win32_LogicalDisk")
    aadd( aClasse,  "Win32_MotherboardDevice")
    aadd( aClasse,  "Win32_NetworkAdapter")
    aadd( aClasse,  "Win32_NetworkAdapterSetting")
    
    aadd( aClasse,  "Win32_NetworkAdapterConfiguration")
    aadd( aClasse,  "Win32_NetworkClient")
    aadd( aClasse,  "Win32_NetworkConnection")
    aadd( aClasse,  "Win32_NetworkLoginProfile")
    aadd( aClasse,  "Win32_NetworkProtocol")
    
    aadd( aClasse,  "Win32_NTEventLogFile")
    aadd( aClasse,  "Win32_NTLogEvent")
    

    aadd( aClasse,  "Win32_NTLogEventLog") 
    aadd( aClasse,  "Win32_NTLogEventComputer")
 
    aadd( aClasse,  "Win32_NTLogEventUser")
    
    aadd( aClasse,  "Win32_OperatingSystem")
    aadd( aClasse,  "Win32_PerfFormattedData_TCPIP_NetworkInterface")
    aadd( aClasse,  "Win32_Printer")
    aadd( aClasse,  "Win32_PrinterDriver")
    aadd( aClasse,  "Win32_Process")
    aadd( aClasse,  "Win32_Processor")
    aadd( aClasse,  "Win32_Refrigeration")
    aadd( aClasse,  "Win32_Service")
    aadd( aClasse,  "Win32_TemperatureProbe")

    CLS
    SetMode(50,150)

    @ 03,15 SAY "[ Select device to list properties ]"
    @ 05,14,25,55 GET n LISTBOX aClasse CAPTION "Select device : " COLOR "W/N,B/W+,W/N,W+/B,W/N,N/W*,G/W*" // Must be 7 Colors
    read
    if lastkey() == K_ESC
    return
   endif
    classe := aClasse[n]

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
          end
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


    return
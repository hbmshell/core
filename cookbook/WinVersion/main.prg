

procedure Main
   
   local oLocator
   local oWMI
   local oSys
   local cReturn
   oLocator  = CreateObject( "WbemScripting.SWbemLocator" )
   oWMI      = oLocator:ConnectServer( ".", "root\cimv2" )
   oSys      = oWMI:ExecQuery( 'Select * from Win32_OperatingSystem' )
   ? "Title : ", oSys:itemIndex( 0 ):Caption 
   ? "Architecture : ", oSys:itemIndex( 0 ):OSArchitecture 
   ? "Build " , oSys:itemIndex( 0 ):BuildNumber


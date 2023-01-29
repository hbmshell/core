#ifdef __DEBUG__
#command COMANDO TESTE => Qout("Debug version")
#else
#command COMANDO TESTE => Qout("Production Version")
#endif

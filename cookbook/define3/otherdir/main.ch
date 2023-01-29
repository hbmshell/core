#ifdef __DEBUG__
#command COMANDO TESTE => Qout("Versao de debug")
#else
#command COMANDO TESTE => Qout("Versao producao")
#endif


PROCEDURE Main

#if __pragma( DEBUGINFO )
    ? "Debug on"
#else
    ? "Debug off"
#endif

#if __pragma( b )
    ? "Debug on (second form)"
#else
    ? "Debug off"
#endif

RETURN



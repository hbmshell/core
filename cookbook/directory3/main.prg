
procedure main()

    LOCAL cPath1 := "\dir\temp"
    LOCAL cPath2 := "/dir/temp"

    ? "Convert O.S. separator : " , cPath1, "--->", hb_DirSepToOS( cPath1 )
    ? "Convert O.S. separator : " , cPath2, "--->", hb_DirSepToOS( cPath2 )

return


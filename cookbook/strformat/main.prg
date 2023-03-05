      //http://www.x-hacker.org/ng/libmisc/ng4354.html
      procedure main 
      ? StrFormat("Please insert disk %1 to drive %2", LTrim(Str(2)), "A:")
      ? StrFormat("This is %1 from %2", "Victor", "Hungary")
      ? StrFormat("%2 %1 %2", "Param1", "Param2")
      ? StrFormat("Hello")
      ? StrFormat("%1 - %2", "one")
      ? StrFormat("%1 - %2", "one", "two")
      ? StrFormat("%2 - %1", "one", "two")
      ? StrFormat("%2 - %", "one", "two")
      ? StrFormat("%% - %", "one", "two")
      ? StrFormat("%9 - %", "one", "two")

      return
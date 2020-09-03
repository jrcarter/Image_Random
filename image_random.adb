-- Image_Random: True random numbers from a digital camera
-- Copyright (C) 2020 by Pragmada Software Engineering
-- Released under the terms of the BSD 3-Clause license; see https://opensource.org/licenses
--
-- 2020-09-01 Initial version
--
with Ada.Directories;
with Ada.Sequential_IO;
with GNAT.OS_Lib;
with GNAT.SHA512;

package body Image_Random is
   function Random return Ada.Streams.Stream_Element_Array is
      File_Name : constant String := "random.png";

      Arg : GNAT.OS_Lib.Argument_List_Access
         := GNAT.OS_Lib.Argument_String_To_List ("/usr/bin/fswebcam -q --no-banner --png 0 " & File_Name);
      Success : Boolean;
   begin -- Random
      GNAT.OS_Lib.Spawn (Program_Name => Arg (Arg'First).all, Args => Arg (Arg'First + 1 .. Arg'Last), Success => Success);
      GNAT.OS_Lib.Free (Arg => Arg);

      if not Success then
         raise Program_Error with "Spawn to capture image failed";
      end if;

      Read_File : declare
         File_Size : constant Ada.Streams.Stream_Element_Count :=
            Ada.Streams.Stream_Element_Count (Ada.Directories.Size (File_Name) );

         subtype Buffer_List is Ada.Streams.Stream_Element_Array (1 .. File_Size);

         package Buffer_IO is new Ada.Sequential_IO (Element_Type => Buffer_List);

         File   : Buffer_IO.File_Type;
         Buffer : Buffer_List;
      begin -- Read_File
         Buffer_IO.Open (File => File, Mode => Buffer_IO.In_File, Name => File_Name);
         Buffer_IO.Read (File => File, Item => Buffer);
         Buffer_IO.Close (File => File);

         return GNAT.SHA512.Digest (Buffer);
      end Read_File;
   end Random;
end Image_Random;

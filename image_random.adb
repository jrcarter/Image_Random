-- Image_Random: True random numbers from a digital camera
-- Copyright (C) by PragmAda Software Engineering
-- SPDX-License-Identifier: BSD-3-Clause
-- See https://spdx.org/licenses/
-- If you find this software useful, please let me know, either through
-- github.com/jrcarter or directly to pragmada@pragmada.x10hosting.com
--
-- 2025-06-01 Use Skein-1024 to allow variable result bytes
-- 2020-09-01 Initial version
--
with Ada.Directories;
with Ada.Sequential_IO;
with Ada.Unchecked_Conversion;
with GNAT.OS_Lib;
with PragmARC.Skein;

package body Image_Random is
   function Random (Num_Bytes : in Positive := 128) return Ada.Streams.Stream_Element_Array is
      File_Name : constant String := "random.png";

      Arg : GNAT.OS_Lib.Argument_List_Access :=
         GNAT.OS_Lib.Argument_String_To_List ("/usr/bin/fswebcam -q --no-banner --png 0 " & File_Name);
      Success : Boolean;
   begin -- Random
      GNAT.OS_Lib.Spawn (Program_Name => Arg (Arg'First).all, Args => Arg (Arg'First + 1 .. Arg'Last), Success => Success);
      GNAT.OS_Lib.Free (Arg => Arg);

      if not Success then
         raise Program_Error with "Spawn to capture image failed";
      end if;

      Read_File : declare
         File_Size : constant Natural := Integer (Ada.Directories.Size (File_Name) );

         subtype Buffer_List is PragmARC.Skein.Byte_List (1 .. File_Size);

         package Buffer_IO is new Ada.Sequential_IO (Element_Type => Buffer_List);

         subtype Result_List is PragmARC.Skein.Byte_List (1 .. Num_Bytes);
         subtype Stream_List is Ada.Streams.Stream_Element_Array (1 .. Ada.Streams.Stream_Element_Offset (Num_Bytes) );

         function To_Stream is new Ada.Unchecked_Conversion (Source => Result_List, Target => Stream_List);

         File   : Buffer_IO.File_Type;
         Buffer : Buffer_List;
      begin -- Read_File
         Buffer_IO.Open (File => File, Mode => Buffer_IO.In_File, Name => File_Name);
         Buffer_IO.Read (File => File, Item => Buffer);
         Buffer_IO.Close (File => File);

         return To_Stream (PragmARC.Skein.Hash (Buffer, Num_Bytes => Num_Bytes, Block_Size => PragmARC.Skein.Size_1024) );
      end Read_File;
   end Random;
end Image_Random;

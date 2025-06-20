-- Image_Random_Test: Test of Image_Random
-- Copyright (C) by PragmAda Software Engineering
-- SPDX-License-Identifier: BSD-3-Clause
-- See https://spdx.org/licenses/
-- If you find this software useful, please let me know, either through
-- github.com/jrcarter or directly to pragmada@pragmada.x10hosting.com
--
-- 2025-06-01 Selectable number of bytes
-- 2020-09-01 Initial version
--
with Ada.Command_Line;
with Ada.Real_Time;
with Ada.Streams;
with Ada.Text_IO;
with Image_Random;

procedure Image_Random_Test is
   Num_Bytes : constant Positive := (if Ada.Command_Line.Argument_Count > 0 then Integer'Value (Ada.Command_Line.Argument (1) )
                                     else 128);
   Start : constant Ada.Real_Time.Time               := Ada.Real_Time.Clock;
   Rand  : constant Ada.Streams.Stream_Element_Array := Image_Random.Random (Num_Bytes);

   use type Ada.Real_Time.Time;
   use type Ada.Streams.Stream_Element_Offset;
begin -- Image_Random_Test
   Ada.Text_IO.Put_Line (Item => "Random time " & Ada.Real_Time.To_Duration (Ada.Real_Time.Clock - Start)'Image);

   Put : for I in Rand'Range loop
      Ada.Text_IO.Put (Item => Rand (I)'Image);

      if I rem 10 = 0 then
         Ada.Text_IO.New_Line;
      end if;
   end loop Put;

   if Rand'Last rem 10 /= 0 then
      Ada.Text_IO.New_Line;
   end if;
end Image_Random_Test;

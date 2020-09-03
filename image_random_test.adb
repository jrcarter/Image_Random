-- Image_Random_Test: Test of Image_Random
-- Copyright (C) 2020 by Pragmada Software Engineering
-- Released under the terms of the BSD 3-Clause license; see https://opensource.org/licenses
--
-- 2020-09-01 Initial version
--
with Ada.Streams;
with Ada.Text_IO;
with Image_Random;

procedure Image_Random_Test is
   Rand : constant Ada.Streams.Stream_Element_Array := Image_Random.Random;
begin -- Image_Random_Test
   Put : for I in Rand'Range loop
      Ada.Text_IO.Put_Line (Item => Ada.Streams.Stream_Element'Image (Rand (I) ) );
   end loop Put;
end Image_Random_Test;

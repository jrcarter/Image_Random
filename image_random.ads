-- Image_Random: True random numbers from a digital camera
-- This works under Linux with the GNAT compiler; modification for other platforms or compilers is left as an exercise for the
-- desperate
-- Ideally, the camera should have its lens cap on, or have a similar dark covering, so the image is of the camera sensor noise
-- However, another randomly changing scene, such as a lava lamp or aquarium, may also work
--
-- Copyright (C) by PragmAda Software Engineering
-- SPDX-License-Identifier: BSD-3-Clause
-- See https://spdx.org/licenses/
-- If you find this software useful, please let me know, either through
-- github.com/jrcarter or directly to pragmada@pragmada.x10hosting.com
--
-- 2025-06-01 Use Skein-1024 to allow variable result bytes
-- 2020-09-01 Initial version
--
with Ada.Streams;

package Image_Random is
   function Random (Num_Bytes : in Positive := 128) return Ada.Streams.Stream_Element_Array;
   -- Captures an image from the default image device to file random.png using jswebcam, reads random.png as a
   -- Stream_Element_Array, and returns the Skein-1024 hash of the data read
   -- Raises Program_Error if capturing the image fails
end Image_Random;

-- Image_Random: True random numbers from a digital camera
-- This works under Linux with the GNAT compiler; modification for other platforms or compilers is left as an exercise for the
-- despearate
-- Ideally, the camera should have its lens cap on, or have a similar dark covering, so the image is of the camera sensor noise
-- However, another randomly changing scene, such as a lava lamp or aquarium, may also work
-- This is slow and only produces 64 random bytes; if you need more, it is probably best to use these bytes to seed a high-quality
-- pseudo-random number generator, such as the Threefry generator
-- Copyright (C) 2020 by Pragmada Software Engineering
-- Released under the terms of the BSD 3-Clause license; see https://opensource.org/licenses
--
-- 2020-09-01 Initial version
--
with Ada.Streams;

package Image_Random is
   function Random return Ada.Streams.Stream_Element_Array;
   -- Captures an image from the default image device to file random.png using jswebcam, reads random.png as a Stream_Element_Array,
   -- and returns the SHA-512 hash of the data read
   -- Raises Program_Error if capturing the image fails
end Image_Random;

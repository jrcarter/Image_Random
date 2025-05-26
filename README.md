# Image_Random (Skein Branch)
True random numbers from a digital camera

This works under Linux with the GNAT compiler; modification for other platforms or compilers is left as an exercise for the desperate

Ideally, the camera should have its lens cap on, or have a similar dark covering, so the image is of the camera sensor noise

However, another randomly changing scene, such as a lava lamp or aquarium, may also work

This version uses the Skein-1024 hash, which can produce a hash of arbitrary length, instead of SHA-512

Program Image_Random_Test takes the number of random bytes to output as a command-line argument, with a default of 128 bytes

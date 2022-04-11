# 3D_self_avoiding_walk

I did not mark the main funciton, all codes are MATLAB sub-functions.
the main code is `PolyGroth3D` function.

- Start MATLAB
- Get access to folder path
- Run `[SpChains_pos_full, List, cro_num_left, mon_num_left, F] = PolyGroth3D(89, 9, 19494, 0.001);`

`89` is the width of 3D network space. The space is a cubic. `9` is the number of crosslinkers, `19494` is the number of monomers. Changing these two parameters can control the ployrization of polymers. Besides, these three parameters together define the polymer fraction. The last `0.001` is the time delay, used for draw 3D network configuration.

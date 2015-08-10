DPM-Octave
==========

This is an GNU Octave version of deformable part-based model (DPM).
The code is converted from the original matlab implementation, i.e., 
voc-release5.0:
http://people.cs.uchicage.edu/~rbg/latent/


Getting started
===============

1. Install the required packages. Start Octave, run `pkg list` to check your installed pacakages. You may need to install some missing packages:
  ```octave
 pkg install -forge general
 pkg install -forge control
 pkg install -forge signal
 pkg install -forge io
 pkg install -forge statistics
 ```
 You may need to download the image package from [here]
(http://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/)
and install `pkg install image-2.2.0.tar.gz`.

2. Compile the MEX C++ code. Run `compile.m`. The compiled .mex files are saved in `./bin/`.

3. Run demo. Run
 ```octave
 startup
 demo
 ```
4. Train a DPM model.
 Prepare your dataset and edit `VOCinit.m` to change the pathes. 
 Run the training and testing scripts, e.g.,
 ```octave
 startup
 inria_main
 ```

5. Convert the .mat model into OpenCV file storage model.
 ```octave
 mat2opencvxml('./INRIA/inriaperson_final.mat', 'inriaperson_cascade_cv.xml');
 ```

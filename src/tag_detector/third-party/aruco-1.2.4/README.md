# ArUco: Augmented Reality library from the University of Cordoba

______________________________________________________________________

ArUco is a minimal C++ library for detection of Augmented Reality markers based on OpenCV exclusively.

It is an educational project to show student how to detect augmented reality markers and it is provided under BSD license.

CONTACT: Rafael Munoz-Salinas: <rmsalinas@uco.es>

## INTRODUCTION

The library relies on the use of coded markers. Each marker has an unique code indicated by the black and white colors in it. The library detect borders, and analyzes into the rectangular regions which of them are likely to be markers. Then, a decoding is performed and if the code is valid, it is considered that the rectangle is a marker.

The codification included into the marker is a slightly modified version of the Hamming Code. It has a total a 25 bits divided in 5 rows of 5 bits each. So, we have 5 words of 5 bits. Each word, contains only 2 bits of real information, the rest is for  and error detection/correction (error correction is yet to be done). As a conclusion, a marker contains 10 bits of real information which allows 1024 different markers.

## LIBRARY DESCRIPTION

The ArUco library contents are divided in two main directories. The `src/` directory, which contains the library itself. And the `utils/` directory which contains the applications.

The library main classes are:

- `aruco::Marker`: which represent a marker detected in the image
- `aruco::MarkerDetector`: that is in charge of detecting the markers in a image Detection is done by simple calling the member function `ArMarkerDetector::detect()`. Additionally, the classes contain members to create the required matrices for rendering using OpenGL. See `aruco_test_gl` for details
- `aruco::BoardConfiguration`: A board is an array of markers in a known order. `BoardConfiguration` is the class that defines a board by indicating the id of its markers. In addition, it has information about the distance between the markers so that extrinsic camera computations can be done.
- `aruco::Board`: This class defines a board detected in a image. The board has the extrinsic camera parameters as public attributes. In addition, it has a method that allows obtain the matrix for getting its position in OpenGL (see aruco_test_board_gl for details).
- `aruco::BoardDetector`: This is the class in charge of detecting a board in a image. You must pass to it the set of markers detected by ArMarkerDetector and the `BoardConfiguration` of the board you want to detect. This class will do the rest for you, even calculating the camera extrinsics.

### BOARDS

ArUco allows the possibility to employ board. Boards are markers composed by an array of markers arranged in a known order. The advantages of using boards instead of simple markers are:

- More robustness. The mis-detection of several markers of the board is not a problem as long as a minimum set of them are detected.
- More precision. Since there are a larger number of corners, camera pose estimation becomes more precise.

A Board contains several markers so that they are more robustly detected.  In general, a board is a set of markers. So BoardConfiguration is only
a list  of the id of the markers along with the position of their corners.

The position of the corners can be specified either in pixels (in a non-specific size) or in meters. The first is the
typical case in which you generate the image of  board  and the print it. Since you do not know in advance the real
size of the markers, their corners are specified in pixels, and then, the translation to meters can be made once you
know the real size. On the other hand, you may want to have the information of your boards in meters in your
configuration file once you have created it. The BoardConfiguration allows you to do so.

Creating boards in managed by two applications. First, use aruco_create_board to create the image of the board.
Print it and use your measurer to know the real size of the markers. Then, you can use aruco_board_pix2meters to create
new configuration file that expresses the board in meters. So, you no longer need to remember the size of your markers.

Since version 1.2, aruco allows to create boards with chessboard configuration. To support the detection of chessboards, we need to apply an erosion in the image when detecting markers.
This is an option that can be disabled in MarkerDetector::enableErosion. By default, it is enabled. However, disabling it can speed up the process up to a 10%. So if you
do not want to use chessboards, disable it.

### APPLICATIONS

- The library comes with five applications that will help you to learn how to use the library:

  - aruco_create_marker: which creates marker and saves it in a jpg file you can print.
  - aruco_simple : simple test application that detects the markers in an image
  - aruco_test: this is the main application for detection. It reads images either from the camera of from a video and detect markers. Additionally, if you provide the intrinsics of the camera(obtained by OpenCv calibration) and the size of the marker in meters, the library calculates the marker intrinsics so that you can easily create your AR applications.
  - aruco_test_gl: shows how to use the library AR applications using OpenGL for rendering
  - aruco_create_board: application that helps you to create a board
  - aruco_board_pix2meters: application that helps you to convert a board configuration file from pixels(as provided by aruco_create_board) to meters.
  - aruco_test_board: application that detects boards
  - aruco_simple_board: simple application that detects boards in an image
  - aruco_test_board_gl: application that detects boards and uses OpenGL to draw

## COMPILING THE LIBRARY

REQUIREMENTS: OpenCV >= 2.3.1, cmake >= 2.8
OPTIONAL:   OpenGL for aruco_test_gl and aruco_test_board_gl

### LINUX

Go to the aruco library and do

```Shell
mkdir build
cd build
cmake ..
make
make install (optional)
```

NOTE ON OPENGL: The library supports easily the integration with OpenGL. In order to compile with support for OpenGL, you just have  installed in your system the develop packages for GL and glut (or freeglut).

### WINDOWS

We have successfully compiled in in two compilers: MSVC2010 and MinGW.
In both cases cmake and OpenCv are required first. So install them

#### Microsoft Visual C++ (Express Edition 2010)

a) Downdload MSVC 2010 (<http://www.microsoft.com/visualstudio/en-us/products/2010-editions/express>).

b) Use cmake to create the project. Compile and run!

#### MinGW and codeblocks

The library has been compiled using MinGW and codeblocks. Below I describe the best way to compile it that I know. If you know better, please let me know.

step 1) codeblocks

- Download codeblocks. I recommend to download the version 10.5 with mingw included (codeblocks-10.05mingw-setup.exe)
- Install and set the PATH variable so that the codeblock/mingw/bin directory is included. In my case "c:\\codeblocks\\mingw\\bin". This will allow cmake to find the compiler.
- The codeblock program will not find the mingw path by default. So, run codeblocks and go to setting->Compiler debugger and set the correct path to the MinGW dir.

step 2) aruco

- Download and decompress.
- Open cmake gui application and set the path to the main library directory and also set a path where the project is going to be built. Generate the codeblock project.
- Open the project with codeblock and compile then, install. The programs will be probably generated into the bin directory

OpenGL: by default, the mingw version installed has not the glut library. SO, the opengl programs are not compiled.  If you want to compile with OpenGL support, you must install glut, or preferably freeglut.
So, download the library (<http://www.martinpayne.me.uk/software/development/GLUT/freeglut-MinGW.zip>) for mingw. Decompress in a directory X. Then, rerun cmake setting the variable GLU_PATH to that directory

```Shell
cmake .. -DGLUT_PATH="C:\x"
```

Finally, recompile and test. Indeed, you should move the freeglut.dll to the directory with the binaries or to any other place in the PATH.

## Testing

For testing the applications, the library provides videos and the corresponding camera parameters of these videos. Into the directories you will find information on how to run the examples.

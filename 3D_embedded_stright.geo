//+
SetFactory("OpenCASCADE");
//+
lc = 1;
// Points:
Point(1) = {-1, -0.5, 0, lc};
Point(2) = {0, -0.5, 0, lc};
Point(3) = {0.7, -0.5, 0, lc};
Point(4) = {0.7, 1.2, 0, lc};
Point(5) = {-1, 1.2, 0, lc};
// Lines
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 1};
// Surfaces
Curve Loop(1) = {4, 5, 1, 2, 3};
Plane Surface(1) = {1};
// Embedded lines in surface 1
Point(6) = {0.1, 0.4, 0, lc};
Line(6) = {2, 6};
Line{6} In Surface{1};
//+
Point(7) = {-0.1, -0.3, 0, lc};
Point(8) = {-0.6, 0.8, 0, lc};
Line(7) = {7, 8};
Line{7} In Surface{1};
// Define the element numbers at lines
Transfinite Curve {1, 2, 3, 4, 5, 6, 7} = 10 Using Progression 1;
// Recombine triangular mesh into quadrangular
Recombine Surface{1};
// 2D Mesh geberation method
Mesh.Algorithm = 11; Mesh.RecombinationAlgorithm = 1; Mesh.RecombineAll = 1;  
//Mesh.Algorithm = 6; Mesh.RecombinationAlgorithm = 1; Mesh.RecombineAll = 1; 
// Generate full 2D quadral meshes
Mesh 2; RecombineMesh; 
// Extrude surfaces and curves along z direction with 10 layers and recombine triangular mesh into quadrangular
Extrude {0, 0, 1} {
  Surface{1}; Curve{1, 2, 3, 4, 5, 6, 7}; Layers {10}; Recombine;
}
// Embedded extrudded lines and surfaces in volume
Surface{7, 8} In Volume{1};
Curve{18, 20, 21} In Volume{1};
// Embedded extrudded lines in extruded surface
Curve{19, 22} In Surface{14};
// 3D Mesh geberation method
Mesh.Algorithm3D = 10; Mesh.SubdivisionAlgorithm = 2; Mesh.Recombine3DAll = 1;
//Mesh.Algorithm3D = 4; Mesh.SubdivisionAlgorithm = 2; Mesh.Recombine3DAll = 1;
// Generate full 3D hexahedral meshes
Mesh 3; //RecombineMesh; 
//RefineMesh; 
//RefineMesh;
// Mesh save 
Mesh.ElementOrder = 1; //linear






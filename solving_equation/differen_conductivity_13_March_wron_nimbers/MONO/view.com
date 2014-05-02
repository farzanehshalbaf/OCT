gfx cre mat copper ambient 1 0.2 0 diffuse 0.6 0.3 0 specular 0.7 0.7 0.5 shininess 0.3
gfx cre mat gold ambient 1 0.4 0 diffuse 1 0.7 0 specular 0.5 0.5 0.5 shininess 0.8
gfx create material silver ambient 0.4 0.4 0.4 diffuse 0.7 0.7 0.7 emission 0 0 0 specular 0.7 0.7 0.7 alpha 1 shininess 0.6
gfx create material red ambient 1 0 0 diffuse 1 0 0
gfx create material green ambient 0 1 0 diffuse 0 1 0



$name = "slides_1_26";

gfx read node ${name}_refined_1
gfx read element ${name}_refined_1

gfx read node laplace_solution_2
gfx read element laplace_solution_2


# Turn on spheres at the nodes:
gfx mod g_e laplace_solution_2 node_points glyph sphere size 0.01 mat default select_on
gfx modify g_element laplace_solution_2 surfaces coordinate coordinates exterior render_shaded material default data potential ;


gfx create window 1 double_buffer
gfx modify window 1 background colour 1 1 1



### Injecting
gfx cre egroup injecting_two
gfx modify egroup injecting_two add 356,364,372,380,388,396,404,412,420,428,436,444,452,460,468,476,484,492,500,508,516,524,532,540,548,556,564,572,580,588,596,604,612,620,628,636,644,652,660,668,676,684,692,700,1060,1068,1076,1084,1092,1100,1108,1116,1124,1132,1140,1148,1156,1164,1172,1180,1188,1196,1204,1212,1220,1228,1236,1244,1252,1260,1268,1276,1284,1292,1300,1308,1316,1324,1332,1340,1348,1356,1364,1372,1380,1388,1396,1404,1436,1444,1452,1468,1500,1508,1516,1532,1564,1572,1580,1596

gfx cre egroup injecting_one
gfx modify egroup injecting_one add 801..824,1001..1008,1153..1176,1353..1360,1755..1760,1807..1808,1833..1835,1858,1957..1959,1982,2101..2103,2126,2145..2146,2168,2200,2257..2259,2282

################ Clour_Bar

gfx cre spectrum grid2

gfx mod spectrum grid2 autorange

gfx create colour_bar spectrum grid2 material copper 

gfx modify g_element "/" point glyph colour_bar general size "1*1*1" centre 0,0,0 select_on material copper selected_material copper normalised_window_fit_left;

gfx create colour_bar spectrum grid2 material copper label_material black as black_label

################### Contours

gfx cre spec contour  linear reverse range 0 1 extend_above extend_below banded number_of_bands 40 band_ratio 0.001 component 1
gfx modify g_element laplace_solution_2 surfaces material bone data potential spectrum contour



################# Electric field arrows
gfx define field derivative_1 node_value fe_field potential d/ds1
gfx define field derivative_2 node_value fe_field potential d/ds2
gfx define field derivative_3 node_value fe_field potential d/ds3  
gfx define field electric_field_orientation component derivative_1 derivative_2 derivative_3 
gfx define field electric_field_magnitude magnitude field electric_field_orientation





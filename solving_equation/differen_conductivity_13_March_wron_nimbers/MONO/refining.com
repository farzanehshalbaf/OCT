
$object='slides_1_26';

fem define parameters;r;${object};example  #Reads parameters needed to define the plate
fem define coordinates;r;${object};example #Reads in the coordinates used for the plate
fem define nodes;r;${object}_refined_3;example       #Reads in the 15 nodes to define the plate
fem define bases;r;${object};example       #Defines a bilinear basis function
fem define elements;r;${object}_refined_3;example




fem refine xi 2 in elements 73..168,289..320,425..520,641..672,777..872,993..1024,1129..1224,1345..1376 at 0.5
fem refine xi 2 in elements 1619..1642,1673..1674,1692..1703,1709..1710,1721..1724,1745..1746,1749..1772 at 0.5
fem refine xi 2 in elements 1779..1780,1805..1812,1830..1841,1857..1860,1910..1921,1937..1940,1954..1965 at 0.5
fem refine xi 2 in elements 1981..1984,2010..2021,2037..2040,2054..2065,2081..2084,2098..2109,2125..2128 at 0.5
fem refine xi 2 in elements 2142..2151,2167..2170,2199..2200,2210..2221,2237..2240,2254..2265,2281..2284 at 0.5

fem refine xi 2 in elements 2169..192,321..328,521..544,673..680,1473..1536,1643..1648,1675..1676,1704..1706 at 0.5
fem refine xi 2 in elements 1725,1877..1888,1922..1924,1941,1993..1996,2022..2024,2041,2066..2068,2085 at 0.5
fem refine xi 2 in elements 2183..2190,2222..2224,2241,2293..2296 at 0.5
fem refine xi 2 in elements 169..192 at 0.5

fem export elem;${object}_refined_4 as ${object}_refined_4
fem export node;${object}_refined_4 as ${object}_refined_4

fem define nodes;w;${object}_refined_4;example               
fem define elem;w;${object}_refined_4;example

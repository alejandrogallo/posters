/*******************/
/* MAIN PARAMETERS */
/*******************/
//defaultpen(fontsize(40));

string LUMO_TITLE = "A - C for 128 cell";

real ENERGIE_LB_PRISTINE    = 17.1560   ;
real ENERGIE_VB_PRISTINE    = 12.7456   ;

real OBERKANTE     = 100;
real UNTERKANTE    = 0;
real IMG_WIDTH     = 2*5+2*25+10;
real KANTEN_HEIGHT = 20;

real[] exc_orientation={
2,
2,
1,
2,
1,
2,
//1,
//2,
//1,
//2,
1,
1,
1,
2,
//1,
//2,
//1,
//2
};
real[] EXCITED_ENERGIES={
14.4950,
15.6083,
13.1596,
13.9573,
12.3120,
12.3691,
//12.3114,
//12.3523,
//12.1687,
//12.3412,
15.1286,
16.8650,
15.7680,
16.8950,
//16.9139,
//16.9244,
//16.9212,
//16.9291
};
real[] EXCITED_SPINS={
1,
2,
1,
2,
1,
2,
//1,
//2,
//1,
//2,
1,
1,
2,
2,
//1,
//2,
//1,
//2
};
real[] EXCITED_OCCUPATION={
1.00000,
1.00000,
1.00000,
0.00000,
1.00000,
1.00000,
//1.00000,
//1.00000,
//1.00000,
//1.00000,
1.00000,
0.00000,
0.00000,
0.00000,
//0.00000,
//0.00000,
//0.00000,
//0.00000
};
real[] EXCITED_BANDS={ 255, 255, 254, 254, 253, 253, 252, 252, 251, 251, 256, 256, 257, 257, 258, 258, 259, 259 };

real[] UNEXCITED_ENERGIES={14.4733,
14.4733,
15.7051,
15.7051,
13.3533,
13.8161,
12.2992,
12.3589,
12.2992,
12.3589,
16.9317,
16.9397};
real[] UNEXCITED_SPINS={1,
1,
2,
2,
1,
2,
1,
2,
1,
2,
1,
2};
real[] UNEXCITED_OCCUPATION={1.00000,
1.00000,
0.00000,
0.00000,
1.00000,
1.00000,
1.00000,
1.00000,
1.00000,
1.00000,
0.00000,
0.00000};
real[] UNEXCITED_BANDS={256,
255,
256,
255,
254,
254,
253,
253,
252,
252,
257,
257};

//size(5cm,5cm);
unitsize(.2cm);


struct state {
  real energy;
  real occupation;
  real band;
  real value;
  string title     = "";
  real spin        = 0;
  real VB          = ENERGIE_VB_PRISTINE;
  real LB          = ENERGIE_LB_PRISTINE;
  real DASH_WIDTH  = 25/2;
  real DASH_HEIGHT = 2;
  real X_COORD     = 0;
  real Y_OFFSET    = 0;
  real getPlottingValue ( ){
    real val = 100*(energy - VB)/(LB-VB);
    return val + Y_OFFSET;
  };
  void init(real e, real s, real o, real b){
    energy     = e;
    if ( o<0.5 ) {
      occupation = 0;
    } else {
      occupation = 1;
    }
    band       = b;
    spin       = s;
    value      = getPlottingValue();
  };
  pair getMiddlePoint (  ){
    real x,y;
    x = X_COORD+(DASH_WIDTH)/2;
    y = value + (DASH_HEIGHT)/2;
    return (x,y);
  };
  void draw_spin(){
    pair middle = getMiddlePoint();
    path ar;
    real x_deviation = 0.25*DASH_WIDTH;
    real height = 5*DASH_HEIGHT;
    pen unoccupied_style = 0.7*white+dashed, occupied_style = black, style;
    if ( occupation == 1 ) {
      style = occupied_style;
    } else {
      style = unoccupied_style;
    }
    if ( spin == 1 ) {
      ar = (middle - (-x_deviation,height))..(middle + (x_deviation,height));
    } else {
      ar = (middle + (-x_deviation,height))..(middle - (x_deviation,height));
    }
    draw(ar, linewidth(2)+style,Arrow());
  };
  void draw (){
    filldraw(box((X_COORD,value),(X_COORD+DASH_WIDTH,value+DASH_HEIGHT)),red, 0.5*white);
    if ( spin != 0 ) {
      draw_spin();
    }
  };
};




/*******************/
/* DRAW DECORATION */
/*******************/
real pointsToEnergy ( real point ){
  return (ENERGIE_LB_PRISTINE-ENERGIE_VB_PRISTINE)*point/100 + ENERGIE_VB_PRISTINE;
};


path UNTERKANTE_BOX = box((0 , UNTERKANTE) , (IMG_WIDTH , UNTERKANTE - KANTEN_HEIGHT));
path OBERKANTE_BOX  = box((0 , OBERKANTE)  , (IMG_WIDTH , OBERKANTE + KANTEN_HEIGHT));

filldraw(OBERKANTE_BOX  , .8*white, 0.5*white);
filldraw(UNTERKANTE_BOX , .8*white, 0.5*white);

real middle = 5+25+5;
draw((middle,0-KANTEN_HEIGHT)--(middle,100+KANTEN_HEIGHT),solid+0.5*white);
label("\scalebox{3}{ \bf GS (A)  }", (5+25/2,OBERKANTE + KANTEN_HEIGHT/2+4));
//label("\scalebox{3}{ \bf (A) }", (5+45/2,OBERKANTE + KANTEN_HEIGHT/2-4));
label("\scalebox{3}{ \bf Excited  }", (5+25+10+25/2,OBERKANTE + KANTEN_HEIGHT/2+4));
label("\scalebox{3}{ \bf (C) }", (5+35+10+25/2,OBERKANTE + KANTEN_HEIGHT/2 -4));




/***************/
/* DRAW STATES */
/***************/
for ( int i = 0; i < EXCITED_ENERGIES.length; i+=1 ) {
  int controller;
  if (exc_orientation[i]==1) {
    controller = 0;
  } else {
    controller = 1;
  }
  state s;
  s.init(EXCITED_ENERGIES[i], EXCITED_SPINS[i], EXCITED_OCCUPATION[i], EXCITED_BANDS[i]);
  s.X_COORD=40+controller*(s.DASH_WIDTH);
  s.draw();
}


for ( int i = 0; i < UNEXCITED_ENERGIES.length; i+=1 ) {
  int controller;
  if ( i%2 == 0 ) {
    controller = 0;
  } else {
    controller = 1;
  }
  state s;
  s.init(UNEXCITED_ENERGIES[i], UNEXCITED_SPINS[i], UNEXCITED_OCCUPATION[i], UNEXCITED_BANDS[i]);
  s.X_COORD=5+controller*(s.DASH_WIDTH);
  s.draw();
}

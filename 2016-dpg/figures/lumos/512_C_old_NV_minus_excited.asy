
string LUMO_TITLE="";

real ENERGIE_LB_PRISTINE   = 17.2450 ;
real ENERGIE_VB_PRISTINE   = 13.0207 ;

real OBERKANTE     = 100;
real UNTERKANTE    = 0;
real IMG_WIDTH     = 50;
real KANTEN_HEIGHT = 20;

bool DRAW_ENERGY     = false;
bool DRAW_BAND       = false;
bool DRAW_OCCUPATION = false;

unitsize(.2cm);
currentpen = fontsize(20);

struct state {
  static int state_count;
  real energy;
  real occupation;
  real band;
  real value;
  pen color;
  pen spin_color;
  pen spin_occupied_color   = black;
  pen spin_unoccupied_color = 0.7*white+dashed;
  pen occupied_color   = red;
  pen unoccupied_color = gray;
  string title         = "";
  real spin            = 0;
  real VB              = ENERGIE_VB_PRISTINE;
  real LB              = ENERGIE_LB_PRISTINE;
  real DASH_WIDTH      = 25;
  real DASH_HEIGHT     = 1.8;
  real X_COORD         = 0;
  real Y_OFFSET        = 0;
  real OCCUPATION_CUTOFF = 0.1;
  real getPlottingValue (){
    real val = 100*(energy - VB)/(LB-VB);
    return val + Y_OFFSET;
  };
  bool isOccupied(){
    if ( occupation >= OCCUPATION_CUTOFF ) {
      return true;
    } else {
      return false;
    }
  };
  state setStyle(){
    real parameter;
    if ( spin != 0 ) {
      parameter = occupation;
    } else {
      parameter = occupation/2;
    }
    color = parameter*occupied_color+(1-parameter)*unoccupied_color;
    spin_color = parameter*spin_occupied_color+(1-parameter)*spin_unoccupied_color+linewidth(3);
    return this;
  };
  void operator init(real energy, real spin, real occupation, real band){
    this.energy     = energy;
    this.occupation = occupation;
    this.band       = band;
    this.spin       = spin;
    this.value      = getPlottingValue();
    state_count    += 1;
    setStyle();
  };
  pair getMiddlePoint (  ){
    real x,y;
    x = X_COORD+(DASH_WIDTH)/2;
    y = value + (DASH_HEIGHT)/2;
    return (x,y);
  };
  state setColors (pen color, pen spin_color=this.spin_color){
    this.color = color;
    this.spin_color = spin_color;
    return this;
  };
  state setAutoPosition (){
    int controller = state_count%2;
    X_COORD=0+controller*(DASH_WIDTH);
    return this;
  };
  bool  isLeft (){
    if ( getMiddlePoint().x >= IMG_WIDTH/2 ) {
      return false;
    }
    else{
      return true;
    }
  };
  bool isUp (){   return spin == 1?true:false; };
  bool isDown (){ return spin == 2?true:false; };
  pair getSpinPosition (bool up=false){
    real x_deviation = 0.25*DASH_WIDTH;
    pair middle      = getMiddlePoint();
    if (up) {
      return (middle - (-x_deviation,0));
    } else {
      return (middle + (-x_deviation,0));
    }
  };
  path getSpinArrow (){
    bool up = isUp();
    pair position = getSpinPosition(up);
    real height = 3*DASH_HEIGHT;
    if (isUp()) {
      return position - (0,height/2) -- position + (0,height/2);
    } else {
      return position + (0,height/2) -- position - (0,height/2);
    }
  };
  state draw_energy (){
    if ( isLeft() ) {
      label((string)energy, (X_COORD,value), W, red);
    } else {
      label((string)energy, (X_COORD+DASH_WIDTH, value), E, red);
    }
    return this;
  };
  state draw_spin(){
    path spinArrow = getSpinArrow();
    draw(spinArrow, spin_color,Arrow(15));
    return this;
  };
  state draw (
      bool draw_band       = false,
      bool draw_occupation = true,
      bool draw_energy     = true
      ){
    filldraw(
        box(
          (X_COORD,value)
          ,(X_COORD+DASH_WIDTH,value+DASH_HEIGHT)
          ),
        color,color*0
        );
    if ( draw_band )
      label(scale(1)*(string)band       , getMiddlePoint() - (DASH_WIDTH/4 , 0) , black);
    if ( draw_occupation && occupation != 0)
      label(scale(1)*(string)occupation , getSpinPosition(!isUp()) , black);
    if ( draw_energy ) draw_energy();
    if ( spin != 0 ) draw_spin();
    return this;
  };
};



//----------------------------
//-  Valence and Cond bands  -
//----------------------------


label(LUMO_TITLE, (25, 100+KANTEN_HEIGHT/1.1), 0.8*blue);

path UNTERKANTE_BOX = box((0 , UNTERKANTE) , (IMG_WIDTH , UNTERKANTE - KANTEN_HEIGHT));
path OBERKANTE_BOX  = box((0 , OBERKANTE)  , (IMG_WIDTH , OBERKANTE + KANTEN_HEIGHT));

pen bandStyle = .8*white;
filldraw(OBERKANTE_BOX  , bandStyle, bandStyle);
filldraw(UNTERKANTE_BOX , bandStyle, bandStyle);







/* DRAW STATES {{{1 */
/********************/

//energy, spin, occupation, band
state(16.7745, 1, 0.00000, 1028)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(16.7745, 1, 0.00000, 1029)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(16.7588, 2, 0.00000, 1026)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(16.7588, 2, 0.00000, 1027)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(16.7585, 2, 0.00000, 1025)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(16.7575, 1, 0.00000, 1026)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(16.7575, 1, 0.00000, 1027)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(16.7543, 1, 0.00000, 1025)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(15.7589, 2, 0.00000, 1024)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(14.2288, 2, 0.00000, 1022)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(15.7589, 2, 1.00000, 1023)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(14.7781, 1, 1.00000, 1024)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(14.7781, 1, 1.00000, 1023)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(13.4247, 1, 1.00000, 1022)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(12.6279, 2, 1.00000, 1021)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(12.6166, 2, 1.00000, 1020)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(12.6166, 2, 1.00000, 1019)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(12.6039, 1, 1.00000, 1021)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(12.6039, 1, 1.00000, 1020)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);

//energy, spin, occupation, band
state(12.5855, 1, 1.00000, 1019)
.setAutoPosition()
.draw( draw_band       = DRAW_BAND,
    draw_occupation = DRAW_OCCUPATION,
    draw_energy     = DRAW_ENERGY
);



//---------------
//-  SCALE  {{{1-
//---------------

real pointsToEnergy ( real point ){
  return (ENERGIE_LB_PRISTINE-ENERGIE_VB_PRISTINE)*point/100 + ENERGIE_VB_PRISTINE;
};
int steps = 2;
real width = 100/steps;

// Bandgap

draw((50,0)--(50,100),dashed+linewidth(.5), Bars(4mm));
label((string)(ENERGIE_LB_PRISTINE-ENERGIE_VB_PRISTINE)+" eV", (50,50), Fill(white));
label("VB", (IMG_WIDTH,0)+UNTERKANTE, N, Fill(white));
label("CB", (IMG_WIDTH,100)+UNTERKANTE, S, Fill(white));


// SCALE
draw((0,0)--(0,100), linewidth(1));
for ( int i = 0; i <= steps; i+=1 ) {
  // SCALE TICKS
  draw((0,width*i)--(2,width*i));
  // SCALE LABELS
  label(scale(0.7)*(string)pointsToEnergy(width*i), (1,width*i), E, Fill(white));
}

// vim: nospell
//vim-run: asy -f pdf % && mupdf $(basename % .asy).pdf &
//vim-run: asy -batchView




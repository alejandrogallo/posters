texpreamble("\usepackage{bm}");
texpreamble("\usepackage{amsmath}");

import flowchart;

currentpen += fontsize(5);
arrowbar currentArrow = Arrow(4);
pen thickPen = currentpen + 1.5pt;
pen thickDotPen = currentpen + 4.5pt;

real dx = 5;

path connection(pair a, pair b, pair bIn = E, pair aOut = (0,0), int fixed=0) {
  pair mid;
  if (bIn == aOut) {
    // same in and out: connection always starts at a
    if (fixed == 0) {
      if (bIn == N) {
        return a--(a.x,b.y);
      } else {
        return a--(b.x,a.y);
      }
    } else {
      if (bIn == N) {
        return (b.x,a.y)--b;
      } else {
        return (a.x,b.y)--b;
      }
    }
  }
  // otherwise: connection starts at a and ends at b
  if (bIn == N) {
    mid = (b.x, a.y);
  } else {
    mid = (a.x, b.y);
  }
  if (a == mid || mid == b) {
    return a--b;
  } else {
    return a--mid--b;
  }
}

path railConnection(path rail, pair b, pair bIn, real dy=0, pen p=currentpen) {
  pair a = (point(rail,length(rail)-1).x, b.y+dy);
  dot(a,p);
  return connection(a,b,bIn,bIn,0);
}


////////////////////////////////////////////////////////////////////////////////
// blocks
////////////////////////////////////////////////////////////////////////////////

real y = 0;

label(graphic("vasp_logo.eps","width=40pt"),(-90,y),N);
label(graphic("FHI-aims-logo.eps","width=60pt"),(+90,y),N);
label(graphic("C2H2n.eps","height=20pt"),(0,y),N);
y -= 25;

block geometryBlock = parallelogram(
  pack(
    "C  0.032  0.000  0.000",
    "C  0.968  0.000  0.500",
    "H  0.143  0.000  0.000",
    "H  0.857  0.000  0.500"
  ),
  (+50,y)
);
draw(geometryBlock);

block cellBlock = parallelogram(
  pack(
    "10.00  0.000  0.000",
    "0.000  8.000  0.000",
    "0.000  0.000  2.460",
    "1$\times$1$\times$7 $k$-points"
  ),
  (-50,y)
);
draw(cellBlock);
y -= 40;


block scfBlock = rectangle(
  "Hartree--Fock SCF",
  "$\hat F\, |\psi_p\rangle = \varepsilon_p\,|\psi_p\rangle$",
  (0,y)
);
draw(scfBlock);
y -= 40;

block pwResolutionOfIdentityBlock = rectangle(
  "Plane-wave RI",
  pack(
    "$\displaystyle S^q_{rG} \
    = \left\langle \psi_q \left| \
      e^{-i \bm{r}\cdot \bm{G}} \right| \psi_r \right\rangle$",
    "$\displaystyle \tilde\Gamma^q_{rG} \
    = S^q_{rG} \sqrt{w_G\frac{4\pi}{\bm{G}^2}}$"
  ),
  (-70,y)
);
draw(pwResolutionOfIdentityBlock);

block dfResolutionOfIdentityBlock = rectangle(
  "Density Fitting RI",
  pack(
    "$\displaystyle S^q_{r\mu} \
    = \left\langle \psi_q \left| \
      \hat C_\mu \right| \psi_r \right\rangle$",
    "$\displaystyle \tilde\Gamma^q_{rG} \
    = S^q_{r\mu} \left[\hat V^\frac12\right]^\mu_G$"
  ),
  (+70,y)
);
draw(dfResolutionOfIdentityBlock);

block pwOrDfBlock = circle(
  "",
  (+20,y-10), drawpen=thickPen
);
draw(pwOrDfBlock);
draw(pwOrDfBlock.top()--pwOrDfBlock.bottom(),currentpen+0.75pt);


y -= 54;
block cbsBlock = rectangle(
  "Quasi CBS data",
  pack(
    "$\epsilon_{ij} = \frac{ \
      (2V^{ij}_{AB}-V^{ji}_{AB}) V^{AB}_{ij}\
    } { \
      \varepsilon_i + \varepsilon_j \
      - \varepsilon_A - \varepsilon_B \
    }$",
    "$\displaystyle \
    D^{ab}_{ij} = \left\langle ab \left| \
      \delta(r_{12}) \right| ij \right\rangle \
    $"
  ),
  (-70,y)
);
draw(cbsBlock);
block auxiliaryFieldBlock = rectangle(
  "Auxiliary-Field SVD",
  pack(
    "$\displaystyle\tilde\Gamma^q_{rG} = U^F_G \Sigma^F_F {W^\ast}^q_{rF}$",
    "$\implies\displaystyle \Gamma^q_{rF} \
    = {U^\ast}^G_F \tilde\Gamma^q_{rG}$"
  ),
  (+70,y)
);
draw(auxiliaryFieldBlock);
y -= 50;


block coulombVertexBlock = parallelogram(
  pack(
    "\texttt{CoulombVertex.yaml}"
  ),
  (+80,y)
);
draw(coulombVertexBlock);

block eigenEnergiesBlock = parallelogram(
  pack(
    "\texttt{EigenEnergies.yaml}"
  ),
  (0,y)
);
draw(eigenEnergiesBlock);

block deltaIntegralsBlock = parallelogram(
  pack(
    "\texttt{DeltaIntegrals.yaml}"
  ),
  (-80,y)
);
draw(deltaIntegralsBlock);

y -= 25;
block coulombVertexSingularVectorsBlock = parallelogram(
  pack(
    "\texttt{Coulomb...SingularVectors.yaml}"
  ),
  (+65,y)
);
draw(coulombVertexSingularVectorsBlock);

block mp2PairEnergiesBlock = parallelogram(
  pack(
    "\texttt{Mp2PairEnergies.yaml}"
  ),
  (-35,y)
);
draw(mp2PairEnergiesBlock);

block gridVectorsBlock = parallelogram(
  pack(
    "\texttt{GridVectors.yaml}"
  ),
  (-95,y)
);
draw(gridVectorsBlock);

y -= 44;
block coulombIntegralsBlock = rectangle(
  "Coulomb integrals",
  pack(
    "$V^{pq}_{sr} = {\Gamma^\ast}^{pF}_s \Gamma^q_{rF}$"
  ),
  (+75,y-6)
);
draw(coulombIntegralsBlock);
block ccsdAmplitudesBlock = rectangle(
  "CCSD Amplitudes",
  pack(
    "$-\Delta^{a}_{i} t^{a}_{i} = V^{lk}_{ic} t^{ac}_{lk} + \ldots$",
    "$-\Delta^{ab}_{ij} t^{ab}_{ij} = V^{ak}_{ic} t^{cb}_{kj} + \ldots$"
  ),
  (-70,y-1)
);
draw(ccsdAmplitudesBlock);

y -= 53;
block ccsdEnergyBlock = rectangle(
  "CCSD Energy",
  pack(
    "$T^{ab}_{ij}= t^{ab}_{ij} + t^a_i t^b_j$",
    "$E_\mathrm{cc} = \left(2V^{ij}_{ab} - V^{ji}_{ab}\right)"
    "T^{ab}_{ij}$"
  ),
  (-70,y)
);
draw(ccsdEnergyBlock);
block ccAddBlock = circle(
  "",
  (0,y-15)
);
draw(ccAddBlock);
label("+",(0,y-15));

block eeEquationOfMotionBlock = rectangle(
  "Equation of Motion",
  pack(
    "$\tilde H | R_n \rangle = E_n | R_n \rangle$",
    "$\tilde H = e^{-\hat T} \hat H e^{+\hat T}$"
  ),
  (+75,y+3)
);
draw(eeEquationOfMotionBlock);


y -= 53;
block triplesEnergyBlock = rectangle(
  "Perturbative triples",
  pack(
    "$-\Delta^{abc}_{ijk} T^{abc}_{ijk} = V^{al}_{ij} t^{bc}_{lk} + \ldots$",
//    "$S^{abc}_{ijk} = T^{abc}_{ijk} + t^a_i V^{bc}_{jk}$",
//    "$Z^{abc}_{ijk} = +8S^{abc}_{ijk} - \ldots$",
    "$E_\mathrm{T} = 8 {T^\ast}^{ijk}_{abc} V^{al}_{ij} t^{bc}_{lk} + \ldots$"
//    "$E_\mathrm{T} = 8 {t^\ast}^{im}_{ab} V_{mc}^{jk} V^{lc}_{jk}  t^{ab}_{il} + \ldots$"
  ),
  (-67,y)
);
draw(triplesEnergyBlock);
block triplesAddBlock = circle(
  "",
  (0,y-15)
);
draw(triplesAddBlock);
label("+",(0,y-15));

block ipEaEquationOfMotionBlock = rectangle(
  "IP/EA EOM CC",
  pack(
    "$\tilde H | R^\pm_n \rangle = E^\pm_n | R^\pm_n \rangle$"
  ),
  (+75,y+5)
);
draw(ipEaEquationOfMotionBlock);

y -= 43;
block correctionsBlock = rectangle(
  "CBS \& TDL correction",
  pack(
    "from $V^{ab}_{cd}t^{cd}_{ij}$ and $S(q)$"
  ),
  (-70,y-2)
);
draw(correctionsBlock);
block correctionsAddBlock = circle(
  "",
  (0,y-8)
);
label("+",(0,y-8));
draw(correctionsAddBlock);


y -= 43;
block gsEnergyBlock = circle(
  "$E_\mathrm{GS}$",
  (0,y)
);
draw(gsEnergyBlock);

block eeEnergyBlock = circle(
  "$\ E_n\ $",
  (+30,y)
);
draw(eeEnergyBlock);
block ipEaEnergyBlock = circle(
  "$E^\pm_n\,$",
  (+60,y)
);
draw(ipEaEnergyBlock);

label(graphic("cc4s_logo.eps","width=60pt"),(-50,y+5));


////////////////////////////////////////////////////////////////////////////////
// connections
////////////////////////////////////////////////////////////////////////////////

draw(
  Label("$\bm{R}_N$",1.5,E),
  connection((+40,10),geometryBlock.top(), N),
  currentArrow
);
draw(
  Label("$\bm{a}_i$",1.5,W),
  connection((-40,10),cellBlock.top(), N),
  currentArrow
);

draw(
//  Label("$\bm{R}_N$",0.5,E),
  connection(geometryBlock.bottom(), scfBlock.right(), E),
  currentArrow
);

path cellConnection = connection(cellBlock.bottom(), scfBlock.left(), E);
draw(
//  Label("$\bm{a}_i,\bm{b}_i,\bm{k}_n$",0.5,W),
  cellConnection, currentArrow
);
pair cellRailStart = point(cellConnection,1);
dot(cellRailStart);
path cellRail = connection(
  cellRailStart, gridVectorsBlock.left()+(-2,+12), N)
;
draw(Label("$\bm{G}_G$",1.835,E),cellRail);
draw(
  connection(endpoint(cellRail),gridVectorsBlock.top(),N),
  currentArrow
);

path scfPwRiConnection = connection(
  scfBlock.bottom()+10W, pwResolutionOfIdentityBlock.right()+10N, E
);
draw(
  Label("$\psi_p$",0.35,W),
  scfPwRiConnection, currentArrow
);
dot(point(scfPwRiConnection,1));
draw(
  connection(point(scfPwRiConnection,1), dfResolutionOfIdentityBlock.left()+10N, E),
  currentArrow
);
draw(
  connection(point(scfPwRiConnection,1), cbsBlock.right()+10S, E),
  currentArrow
);

draw(
  railConnection(cellRail, pwResolutionOfIdentityBlock.left()+10N, E),
  currentArrow
);

path scfCbsConnection = connection(
  scfBlock.bottom()+10E, cbsBlock.right()+10N,E
);
draw(
  Label("$\varepsilon_p$",0.12,E),
  scfCbsConnection, currentArrow
);
dot(point(scfCbsConnection,1));
draw(
  connection(point(scfCbsConnection,1), eigenEnergiesBlock.top()+10E, N),
  currentArrow
);

draw(
  Label("$E_\mathrm{HF}$", 0.93, W),
  connection(scfBlock.bottom(), eigenEnergiesBlock.top(), N),
  currentArrow
);

draw(
  Label("$U^F_G$",0.24,E),
  connection(
    auxiliaryFieldBlock.bottom()+25W,coulombVertexSingularVectorsBlock.top(),
    N, N
  ),
  currentArrow
);


draw(
  Label("$\varepsilon_{ij}$",0.24,W),
  connection(
    cbsBlock.bottom()+30E,mp2PairEnergiesBlock.top(),
    N, N
  ),
  currentArrow
);

draw(
  Label("$D^{ab}_{ij}$",0.5,W),
  connection(
    cbsBlock.bottom()+10W,deltaIntegralsBlock.top(),
    N, N
  ),
  thickPen, currentArrow
);


path coulombVertexRail = connection(
  coulombVertexBlock.right(),
  (coulombVertexBlock.right().x+10, coulombIntegralsBlock.right().y+6),
  N
);
draw(coulombVertexRail, thickPen);
draw(
  endpoint(coulombVertexRail)--(coulombIntegralsBlock.right()+6N),
  thickPen, currentArrow
);


path eigenEnergiesRail = connection(
  eigenEnergiesBlock.bottom()+10E, triplesAddBlock.left()+30N, N, N, 0
);
draw(eigenEnergiesRail);
draw(
  connection(endpoint(eigenEnergiesRail), triplesEnergyBlock.right(),E, E, 0),
  currentArrow
);
draw(
  railConnection(
    eigenEnergiesRail,
    (ccsdEnergyBlock.right().x, ccAddBlock.right().y+30),
    E
  ),
  currentArrow
);
draw(
  railConnection(
    eigenEnergiesRail,
    (eeEquationOfMotionBlock.left().x, ccAddBlock.right().y+30),
    E
  ),
  currentArrow
);
draw(
  railConnection(
    eigenEnergiesRail,
    (ipEaEquationOfMotionBlock.left().x, triplesAddBlock.right().y+30),
    E
  ),
  currentArrow
);


draw(
//  Label("$E_\mathrm{HF}$", 0.3, W),
  connection(eigenEnergiesBlock.bottom(), ccAddBlock.top(), N),
  currentArrow
);

draw(
  connection(ccsdEnergyBlock.right()+10S, ccAddBlock.left(), E),
  currentArrow
);

draw(
  connection(ccAddBlock.bottom(), triplesAddBlock.top(), N),
  currentArrow
);

draw(
  connection(triplesEnergyBlock.right()+10S,triplesAddBlock.left(), E),
  currentArrow
);

draw(
  connection(triplesAddBlock.bottom(), correctionsAddBlock.top(), N),
  currentArrow
);

draw(
  connection(correctionsBlock.right(),correctionsAddBlock.left(), E),
  currentArrow
);

draw(
  connection(correctionsAddBlock.bottom(), gsEnergyBlock.top(), N),
  currentArrow
);


draw(
  connection(
    pwResolutionOfIdentityBlock.right(), pwOrDfBlock.left(), E, E, 1
  ),
  thickPen, currentArrow
);
draw(
  connection(dfResolutionOfIdentityBlock.left()+10S, pwOrDfBlock.right(), E, E, 1),
  thickPen, currentArrow
);
path orAuxiliaryFieldConnection = connection(
  pwOrDfBlock.bottom(), auxiliaryFieldBlock.left(), E
);
draw(
  Label("${\tilde\Gamma}^q_{rG}$",0.3,2E),
  orAuxiliaryFieldConnection, thickPen, currentArrow
);
dot(point(orAuxiliaryFieldConnection,1), thickDotPen);
draw(
  connection(point(orAuxiliaryFieldConnection,1), cbsBlock.right(), E),
  thickPen, currentArrow
);
draw(
  Label("$\Gamma^q_{rF}$",0.5,E),
  connection(
    auxiliaryFieldBlock.bottom()+10E,coulombVertexBlock.top(),
    N, N
  ),
  thickPen, currentArrow
);


path coulombIntegralsRail = connection(
  coulombIntegralsBlock.left()+6N, (30,triplesAddBlock.right().y+20), N
);
draw(
  Label("$V^{pq}_{sr}$",0.8,2N),
  coulombIntegralsRail,
  thickPen
);
draw(
  connection(endpoint(coulombIntegralsRail), triplesEnergyBlock.right(),E,E,0),
  thickPen, currentArrow
);

draw(
  railConnection(
    coulombIntegralsRail,
    (ccsdAmplitudesBlock.right().x,point(coulombIntegralsRail,0).y),
    E, thickDotPen
  ),
  thickPen, currentArrow
);

draw(
  railConnection(
    coulombIntegralsRail, (ccsdEnergyBlock.right().x, ccAddBlock.right().y+20), E,
    thickDotPen
  ),
  thickPen, currentArrow
);
draw(
  railConnection(
    coulombIntegralsRail, (eeEquationOfMotionBlock.left().x, ccAddBlock.right().y+20), E,
    thickDotPen
  ),
  thickPen, currentArrow
);
draw(
  railConnection(
    coulombIntegralsRail, (ipEaEquationOfMotionBlock.left().x, triplesAddBlock.right().y+20), E,
    thickDotPen
  ),
  thickPen, currentArrow
);

draw(
  Label("$\Gamma^q_{rF}$",0.0,2NW),
  railConnection(
    coulombVertexRail,
    (ccsdAmplitudesBlock.right().x, point(coulombIntegralsRail,0).y+20),
    E
  ),
  thickPen, currentArrow
);


draw(
  Label("$\varepsilon_p$", 0.0, 2E),
  railConnection(
    eigenEnergiesRail,
    (ccsdAmplitudesBlock.right().x, point(coulombIntegralsRail,0).y+10),
    E
  ),
  currentArrow
);


path amplitudesRail = connection(
  (ccsdAmplitudesBlock.right().x, point(coulombIntegralsRail,0).y-10),
  (+20,correctionsAddBlock.right().y+10),
  N
);
draw(
  Label("$t^{a}_{i},t^{ab}_{ij}$",0.0,2SE),
  amplitudesRail, thickPen
);

draw(
  railConnection(
    amplitudesRail, (ccsdEnergyBlock.right().x, ccAddBlock.right().y+10), E,
    thickDotPen
  ),
  thickPen, currentArrow
);
draw(
  railConnection(
    amplitudesRail, (eeEquationOfMotionBlock.left().x, ccAddBlock.right().y+10), E,
    thickDotPen
  ),
  thickPen, currentArrow
);

draw(
  railConnection(
    amplitudesRail, (triplesEnergyBlock.right().x, triplesAddBlock.right().y+10), E,
    thickDotPen
  ),
  thickPen, currentArrow
);

draw(
  railConnection(
    amplitudesRail, (ipEaEquationOfMotionBlock.left().x, triplesAddBlock.right().y+10), E,
    thickDotPen
  ),
  thickPen, currentArrow
);

draw(
  connection(endpoint(amplitudesRail), correctionsBlock.right(), E,E,0),
  thickPen, currentArrow
);

draw(
  connection(ipEaEquationOfMotionBlock.bottom(),ipEaEnergyBlock.top(),N,N,1),
  currentArrow
);

path eeEnergyRail = connection(
  eeEquationOfMotionBlock.right(),
  (coulombVertexBlock.right().x+10,correctionsAddBlock.right().y),
  N
);
draw(eeEnergyRail);
draw(
  connection(endpoint(eeEnergyRail), eeEnergyBlock.top(), N),
  currentArrow
);

path cbsTdlInfoRail = connection(
  (auxiliaryFieldBlock.bottom().x-25,coulombVertexSingularVectorsBlock.bottom().y),
  (ccsdAmplitudesBlock.left().x-6, ccsdAmplitudesBlock.top().y+7),
  E
);
draw(cbsTdlInfoRail);
draw(
  (cbsBlock.bottom().x+30,mp2PairEnergiesBlock.bottom().y)
  --(cbsBlock.bottom().x+30,endpoint(cbsTdlInfoRail).y)
);
draw(
  gridVectorsBlock.bottom()--(gridVectorsBlock.bottom().x,endpoint(cbsTdlInfoRail).y)
);
draw(
  connection(
    endpoint(cbsTdlInfoRail),
    (correctionsBlock.left().x, correctionsAddBlock.right().y+10),
    E
  ),
  currentArrow
);

path deltaIntegralsConnection = connection(
  deltaIntegralsBlock.left(),
  (correctionsBlock.left().x-18, correctionsAddBlock.right().y), N
);
draw(deltaIntegralsConnection, thickPen);
draw(
  Label("$D^{ab}_{ij}$",0.5,2S),
  connection(endpoint(deltaIntegralsConnection), correctionsBlock.left(), E,E,0),
  thickPen, currentArrow
);



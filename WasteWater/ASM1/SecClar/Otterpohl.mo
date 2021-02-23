within WasteWater.ASM1.SecClar;
package Otterpohl "Secondary settling tank modelling by Otterpohl" 
  extends Modelica.Icons.Library;
  
  annotation (
    Coordsys(
      extent=[0, 0; 442, 386], 
      grid=[2, 2], 
      component=[20, 20]), 
    Window(
      x=0.45, 
      y=0.01, 
      width=0.44, 
      height=0.65, 
      library=1, 
      autolayout=1), 
    Documentation(info="This package contains classes (layer models) to built ASM1 secondary clarifier models, an Interfaces sub-library
and provides an ASM1 10-layer secondary clarifier model all bases on Otterpohls`s [1] 
sedimentation velocities for macro and micro flocs and the omega correction function.

A secondary clarifier layer model needs at least a top_layer, a feed_layer and a bottom_layer
and may have several upper_layer in between above the feed_layer and several lower_layer in
between below the feed_layer.

Main Author:
   Gerald Reichl
   Technische Universitaet Ilmenau
   Faculty of Informatics and Automation
   Department Dynamics and Simulation of ecological Systems
   P.O. Box 10 05 65
   98684 Ilmenau
   Germany
   email: gerald.reichl@tu-ilmenau.de

References:

[1] R. Otterpohl and M. Freund: Dynamic models for clarifiers of activated sludge plants
    with dry and wet weather flows. Water Science and Technology. 26 (1992), pp 1391-1400.

This package is free software; it can be redistributed and/or modified under the terms of the Modelica license, see the license conditions and the accompanying
disclaimer in the documentation of package Modelica in file \"Modelica/package.mo\".

Copyright (C) 2003, Gerald Reichl
"));
  package Interfaces 
    "Connectors and partial ASM1 models for Secondary Clarifier Model by Otterpohl"
     
    
    extends Modelica.Icons.Library;
    
    connector UpperLayerPin "Connector above influent layer" 
      
      package WWU = WasteWater.WasteWaterUnits;
      // effluent flow
      flow WWU.VolumeFlowRate Qe;
      // sedimentation flux (from micro and macro flocs)
      flow WWU.SedimentationFlux SedFlux_F;
      // caused by macro flocs
      flow WWU.SedimentationFlux SedFlux_S;
      // caused by micro flocs
      
      
        // sludge concentration of macro and micro flocs in (m-1)-th layer (dn=down)
      WWU.MassConcentration X_dn_F;
      WWU.MassConcentration X_dn_S;
      
      // soluble components
      WWU.MassConcentration Si;
      WWU.MassConcentration Ss;
      WWU.MassConcentration So;
      WWU.MassConcentration Sno;
      WWU.MassConcentration Snh;
      WWU.MassConcentration Snd;
      WWU.Alkalinity Salk;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.1, 
          y=0.03, 
          width=0.35, 
          height=0.49), 
        Documentation(info=
              "Connector for ASM1 information and mass exchange between layers above the influent layer (feed_layer)."
          ));
    end UpperLayerPin;
    connector LowerLayerPin "Connector below influent layer" 
      
      package WWU = WasteWater.WasteWaterUnits;
      
      // return and waste sludge flow Qr, Qw
      flow WWU.VolumeFlowRate Qr;
      flow WWU.VolumeFlowRate Qw;
      
      // sedimentation flux (from micro and macro flocs)
      flow WWU.SedimentationFlux SedFlux_F;
      // caused by macro flocs
      flow WWU.SedimentationFlux SedFlux_S;
      // caused by micro flocs
      
      // total sludge concentration of micro and macro flocs in m-th layer
      WWU.MassConcentration X_F;
      WWU.MassConcentration X_S;
      
        // total sludge concentration of micro and macro flocs in (m-1)-th layer (dn=down)
      WWU.MassConcentration X_dn_F;
      WWU.MassConcentration X_dn_S;
      // sink velocity of macro flocs in (m-1)-th layer
      WWU.SedimentationVelocity vS_dn_F;
      // soluble components
      WWU.MassConcentration Si;
      WWU.MassConcentration Ss;
      WWU.MassConcentration So;
      WWU.MassConcentration Sno;
      WWU.MassConcentration Snh;
      WWU.MassConcentration Snd;
      WWU.Alkalinity Salk;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.02, 
          y=0.03, 
          width=0.35, 
          height=0.49), 
        Documentation(info=
              "Connector for ASM1 information and mass exchange between layers below the influent layer (feed_layer)."
          ));
    end LowerLayerPin;
    partial model SCParam "partial model providing clarifier parameters" 
      package SI = Modelica.SIunits;
      package WWU = WasteWater.WasteWaterUnits;
      parameter SI.Length zm;
      parameter SI.Area Asc;
      parameter WWU.SludgeVolumeIndex ISV;
      parameter WWU.SedimentationVelocity vS_S=0.24;
      // 0.01[m/h]*24 -> [m/d]
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.1, 
          y=0.05, 
          width=0.35, 
          height=0.49), 
        Documentation(info="partial model providing clarifier parameters"));
    end SCParam;
    partial model SCVar "partial models providing variables" 
      
      package WWU = WasteWater.WasteWaterUnits;
      WWU.MassConcentration X "total sludge concentration in m-th layer";
      WWU.MassConcentration X_F "sludge concentration of macro flocs";
      WWU.MassConcentration X_S "sludge concentration of micro flocs";
      WWU.SedimentationVelocity vS_F "sink velocity of makro flocs";
      WWU.SedimentationFlux Jsm_F "sedimentation flux of macro flocs";
      WWU.SedimentationFlux Jsm_S "sedimentation flux of micro flocs";
      
      WWU.MassConcentration Si "Soluble inert organic matter";
      WWU.MassConcentration Ss "Readily biodegradable substrate";
      WWU.MassConcentration So "Dissolved oxygen";
      WWU.MassConcentration Sno "Nitrate and nitrite nitrogen";
      WWU.MassConcentration Snh "Ammonium nitrogen";
      WWU.MassConcentration Snd "Soluble biodegradable organic nitrogen";
      WWU.Alkalinity Salk "Alkalinity";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.03, 
          y=0.05, 
          width=0.35, 
          height=0.49), 
        Documentation(info="partial models providing ASM1 variables"));
    end SCVar;
    partial model ratios "partial model for ratios of solid components" 
      
      // ratios of solid components
      Real rXi;
      Real rXs;
      Real rXbh;
      Real rXba;
      Real rXp;
      Real rXnd;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.03, 
          y=0.04, 
          width=0.35, 
          height=0.49), 
        Documentation(info="partial model for ASM1 ratios of solid components")
        );
    end ratios;
    function vSfun "Sedimentation velocity function" 
      
      // total sludge concentration in m-th layer in g/m3 or mg/l
      input Real X;
      //Sludge Volume Index
      input Real ISV;
      // sink velocity in m/d
      output Real vS;
    protected 
      Real v0 "maximum settling velocity";
      Real nv "exponent as part of the Vesilind equation";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.08, 
          y=0.07, 
          width=0.35, 
          height=0.49), 
        Documentation(info="Sedimentation velocity function"));
    algorithm 
      v0 := (17.4*(exp(-0.0113*ISV)) + 3.931)*24;
      //[m/d]
      nv := (-0.9834*(exp(-0.00581*ISV)) + 1.043);
      //[l/g]
      vS := v0*exp(-nv*X/1000);
    end vSfun;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 386], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.44, 
        height=0.65, 
        library=1, 
        autolayout=1), 
      Documentation(info="This package contains connectors and interfaces (partial models) for
the ASM1 secondary clarifier model based on Otterpohl [1] (two settling velocities for
distinction between micro and macro flocs and omega correction function).

References:

[1] R. Otterpohl and M. Freund: Dynamic models for clarifiers of activated sludge plants
    with dry and wet weather flows. Water Science and Technology. 26 (1992), pp 1391-1400.

Main Author:
   Gerald Reichl
   Technische Universitaet Ilmenau
   Faculty of Informatics and Automation
   Department Dynamics and Simulation of ecological Systems
   P.O. Box 10 05 65
   98684 Ilmenau
   Germany

This package is free software; it can be redistributed and/or modified under the terms of the Modelica license, see the license conditions and the accompanying
disclaimer in the documentation of package Modelica in file \"Modelica/package.mo\".

Copyright (C) 2003, Gerald Reichl
"));
    function omega "Omega correction function by Haertel" 
      
      input Real z;
      //vertical coordinate, bottom: z=0
      input Real Xf;
      // total sludge concentration in clarifier feed
      input Real hsc;
      //height of secondary clarifier
      input Real zm;
      //height of m-th secondary clarifier layer
      input Real ISV;
      //Sludge Volume Index
      input Integer i;
      //number of layers above feed layer
      
      // correction function omega by Haertel based on [g/l]
      output Real omega;
      
    protected 
      Real Xc "solids concentration at compression point";
      Real nv "exponent as part of the Vesilind equation";
      Real ht "height of transition point";
      Real hc "height of compressing point";
      Real B3;
      Real B4;
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.07, 
          y=0.09, 
          width=0.35, 
          height=0.49), 
        Documentation(info=
              "This is Haertels omega correction function for the settling process."
          ));
    algorithm 
      
      Xc := 480/ISV;
      nv := 1.043 - 0.9834*exp(-0.00581*ISV);
      hc := (Xf/1000)*(hsc - zm*(i + 0.5))/Xc*(1.0 - 1.0/(Xc*nv));
      // unit change
      ht := min(2.0*hc, hsc - zm*(i + 0.5));
      
      B4 := 1.0 + 2.0*ISV/(100.0 + ISV);
      B3 := -((2*ISV + 100.0)/ISV)*hc^B4;
      
      omega := (1.0 - B3*ht^(-B4))/(1.0 - B3*z^(-B4));
      omega := min(1.0, omega);
    end omega;
  end Interfaces;
  model SecClarModOtter "Secondary Clarifier Model based on Otterpohl (ASM1)" 
    
    extends WasteWater.Icons.SecClar;
    extends ASM1.SecClar.Otterpohl.Interfaces.ratios;
    package SCP = ASM1.SecClar.Otterpohl;
    package SI = Modelica.SIunits;
    package WI = ASM1.Interfaces;
    package WWU = WasteWater.WasteWaterUnits;
    parameter SI.Length hsc=4.0 "height of secondary clarifier";
    parameter Integer n=10 "number of layers of SC model";
    parameter SI.Length zm=hsc/(1.0*n) 
      "height of m-th secondary clarifier layer";
    parameter SI.Area Asc=1500.0 "area of secondary clarifier";
    parameter WWU.SludgeVolumeIndex ISV=130 "Sludge Volume Index";
    parameter Integer i=2 
      "number of layers above current feed layer in this model";
    
    // total sludge concentration in clarifier feed
    WWU.MassConcentration Xf;
    
    // layers 1 to 10  
    SCP.bottom_layer S1(
      zm=zm, 
      Asc=Asc, 
      ISV=ISV, 
      rXs=rXs, 
      rXbh=rXbh, 
      rXba=rXba, 
      rXp=rXp, 
      rXi=rXi, 
      rXnd=rXnd) annotation (extent=[-35, -93; 35, -78]);
    SCP.lower_layer S2(
      hsc=hsc, 
      zm=zm, 
      z=(zm + zm/2), 
      Asc=Asc, 
      ISV=ISV, 
      i=i, 
      Xf=Xf) annotation (extent=[-35, -74; 35, -59]);
    SCP.lower_layer S3(
      hsc=hsc, 
      zm=zm, 
      z=(2*zm + zm/2), 
      Asc=Asc, 
      ISV=ISV, 
      i=i, 
      Xf=Xf) annotation (extent=[-35, -55; 35, -40]);
    SCP.lower_layer S4(
      hsc=hsc, 
      zm=zm, 
      z=(3*zm + zm/2), 
      Asc=Asc, 
      ISV=ISV, 
      i=i, 
      Xf=Xf) annotation (extent=[-35, -36; 35, -21]);
    SCP.lower_layer S5(
      hsc=hsc, 
      zm=zm, 
      z=(4*zm + zm/2), 
      Asc=Asc, 
      ISV=ISV, 
      i=i, 
      Xf=Xf) annotation (extent=[-35, -17; 35, -2]);
    SCP.lower_layer S6(
      hsc=hsc, 
      zm=zm, 
      z=(5*zm + zm/2), 
      Asc=Asc, 
      ISV=ISV, 
      i=i, 
      Xf=Xf) annotation (extent=[-35, 2; 35, 17]);
    SCP.lower_layer S7(
      hsc=hsc, 
      zm=zm, 
      z=(6*zm + zm/2), 
      Asc=Asc, 
      ISV=ISV, 
      i=i, 
      Xf=Xf) annotation (extent=[-35, 21; 35, 36]);
    SCP.feed_layer S8(
      hsc=hsc, 
      zm=zm, 
      z=(7*zm + zm/2), 
      Asc=Asc, 
      ISV=ISV, 
      i=i, 
      Xf=Xf) annotation (extent=[-35, 40; 35, 55]);
    SCP.upper_layer S9(
      zm=zm, 
      Asc=Asc, 
      ISV=ISV) annotation (extent=[-35, 59; 35, 74]);
    SCP.top_layer S10(
      zm=zm, 
      Asc=Asc, 
      ISV=ISV, 
      rXs=rXs, 
      rXbh=rXbh, 
      rXba=rXba, 
      rXp=rXp, 
      rXi=rXi, 
      rXnd=rXnd) annotation (extent=[-35, 78; 35, 93]);
    WI.WWFlowAsm1in Feed annotation (extent=[-110, 4; -90, 24]);
    WI.WWFlowAsm1out Effluent annotation (extent=[92, 47; 112, 67]);
    WI.WWFlowAsm1out Return annotation (extent=[-40, -106; -20, -86]);
    WI.WWFlowAsm1out Waste annotation (extent=[20, -106; 40, -86]);
    annotation (
      Documentation(info="This component models an ASM1 10 - layer secondary clarifier model with 4 layers above the feed_layer (including top_layer)
and 5 layers below the feed_layer (including bottom_layer) based on Otterpohl`s theory.

Parameters:
  hsc -  height of clarifier [m]
  n   -  number of layers
  Asc -  surface area of sec. clar. [m2]
  ISV -  Sludge Volume Index [ml/g]
  i   -  number of layers above feed layer
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.02, 
        y=0.03, 
        width=0.35, 
        height=0.49));
  equation 
    
    connect(S1.Up, S2.Dn) annotation (points=[-2.22045e-15, -78; -2.22045e-15, 
          -74]);
    connect(S2.Up, S3.Dn) annotation (points=[-2.22045e-15, -59; -2.22045e-15, 
          -55]);
    connect(S3.Up, S4.Dn) annotation (points=[-2.22045e-15, -40; -2.22045e-15, 
          -36]);
    connect(S5.Up, S6.Dn) annotation (points=[-2.22045e-15, -2; -2.22045e-15, 2
          ]);
    connect(S6.Up, S7.Dn) annotation (points=[-2.22045e-15, 17; -2.22045e-15, 
          21]);
    connect(S7.Up, S8.Dn) annotation (points=[-2.22045e-15, 36; -2.22045e-15, 
          40]);
    connect(S9.Up, S10.Dn) annotation (points=[-2.22045e-15, 74; -2.22045e-15, 
          78]);
    connect(S4.Up, S5.Dn) annotation (points=[-2.22045e-15, -21; -2.22045e-15, 
          -17]);
    connect(S8.Up, S9.Dn) annotation (points=[-2.22045e-15, 55; -2.22045e-15, 
          59]);
    connect(Feed, S8.In) annotation (points=[-98, 14; -98, 47.8; -33, 47.8]);
    connect(S1.PQw, Waste) annotation (points=[17.5, -93; 17.5, -100; 30, -100]
      );
    connect(S10.Out, Effluent) annotation (points=[35, 85.5; 67.5, 85.5; 67.5, 
          57; 100, 57]);
    connect(S1.PQr, Return) annotation (points=[-21, -93; -21, -100; -30, -100]
      );
    
    // total sludge concentration in clarifier feed
    Xf = 0.75*(Feed.Xs + Feed.Xbh + Feed.Xba + Feed.Xp + Feed.Xi);
    
    // ratios of solid components
    rXs = Feed.Xs/Xf;
    rXbh = Feed.Xbh/Xf;
    rXba = Feed.Xba/Xf;
    rXp = Feed.Xp/Xf;
    rXi = Feed.Xi/Xf;
    rXnd = Feed.Xnd/Xf;
    
  end SecClarModOtter;
  model bottom_layer "Bottom layer of Otterpohls`s SC model" 
    
    package WWSC = WasteWater.ASM1.SecClar.Otterpohl.Interfaces;
    extends WWSC.SCParam;
    extends WWSC.SCVar;
    extends WWSC.ratios;
    ASM1.Interfaces.WWFlowAsm1out PQr annotation (extent=[-70, -110; -50, -90])
      ;
    ASM1.Interfaces.WWFlowAsm1out PQw annotation (extent=[40, -110; 60, -90]);
    WWSC.LowerLayerPin Up annotation (extent=[-10, 90; 10, 110]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.35, 
        height=0.49), 
      Documentation(info="This class models the lowest layer of an ASM1 secondary clarifier based on Otterpohl.

No sedimentation flux (mass exchange) with underneath but hydraulic and sedimentation flux (same direction)
with above layer.
From here return and waste sludge is removed.
"), 
      Icon(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Text(extent=[-100, 20; 100, -20], string="%name"), 
        Polygon(points=[-68, -40; -68, -58; -76, -58; -60, -68; -44, -58; -52, 
              -58; -52, -40; -68, -40], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, 68; -68, 50; -76, 50; -60, 40; -44, 50; -52, 50; -
              52, 68; -68, 68], style(pattern=0, fillColor=69)), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48))), 
      Diagram(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Polygon(points=[-68, -40; -68, -58; -76, -58; -60, -68; -44, -58; -52, 
              -58; -52, -40; -68, -40], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, 68; -68, 50; -76, 50; -60, 40; -44, 50; -52, 50; -
              52, 68; -68, 68], style(pattern=0, fillColor=69)), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48))));
  equation 
    
    // sink velocity
    vS_F = WWSC.vSfun(X_F, ISV);
    
    // sedimentation flux in bottom layer
    Jsm_F = 0.0;
    Jsm_S = 0.0;
    
    // ODE of solid component
    der(X_F) = ((Up.Qr + Up.Qw)/Asc*(Up.X_F - X_F) + Up.SedFlux_F)/zm;
    der(X_S) = ((Up.Qr + Up.Qw)/Asc*(Up.X_S - X_S) + Up.SedFlux_S)/zm;
    
    X = X_F + X_S;
    
    // ODEs of soluble components
    der(Si) = (Up.Qr + Up.Qw)*(Up.Si - Si)/(Asc*zm);
    der(Ss) = (Up.Qr + Up.Qw)*(Up.Ss - Ss)/(Asc*zm);
    der(So) = (Up.Qr + Up.Qw)*(Up.So - So)/(Asc*zm);
    der(Sno) = (Up.Qr + Up.Qw)*(Up.Sno - Sno)/(Asc*zm);
    der(Snh) = (Up.Qr + Up.Qw)*(Up.Snh - Snh)/(Asc*zm);
    der(Snd) = (Up.Qr + Up.Qw)*(Up.Snd - Snd)/(Asc*zm);
    der(Salk) = (Up.Qr + Up.Qw)*(Up.Salk - Salk)/(Asc*zm);
    
    // upward connection
    Up.vS_dn_F = vS_F;
    Up.X_dn_F = X_F;
    Up.X_dn_S = X_S;
    
    // return and waste sludge volume flow rates
    PQr.Q + Up.Qr = 0;
    PQw.Q + Up.Qw = 0;
    
    // return sludge flow, solid and soluble components (ASM1)
    PQr.Si = Si;
    PQr.Ss = Ss;
    PQr.Xi = rXi*X;
    PQr.Xs = rXs*X;
    PQr.Xbh = rXbh*X;
    PQr.Xba = rXba*X;
    PQr.Xp = rXp*X;
    PQr.So = So;
    PQr.Sno = Sno;
    PQr.Snh = Snh;
    PQr.Snd = Snd;
    PQr.Xnd = rXnd*X;
    PQr.Salk = Salk;
    
    // waste sludge flow, solid and soluble components (ASM1)
    PQw.Si = Si;
    PQw.Ss = Ss;
    PQw.Xi = rXi*X;
    PQw.Xs = rXs*X;
    PQw.Xbh = rXbh*X;
    PQw.Xba = rXba*X;
    PQw.Xp = rXp*X;
    PQw.So = So;
    PQw.Sno = Sno;
    PQw.Snh = Snh;
    PQw.Snd = Snd;
    PQw.Xnd = rXnd*X;
    PQw.Salk = Salk;
    
  end bottom_layer;
  model lower_layer "Layer below influent of Otterpohl`s SC model" 
    
    package WWSC = WasteWater.ASM1.SecClar.Otterpohl.Interfaces;
    extends WWSC.SCParam;
    extends WWSC.SCVar;
    WWU.MassConcentration Xf "sludge concentration in clarifier feed";
    SI.Length z "vertical coordinate of current layer";
    parameter SI.Length hsc;
    parameter Integer i "number of layers above feed layer";
    Real omega;
    WWSC.LowerLayerPin Up annotation (extent=[-10, 90; 10, 110]);
    WWSC.LowerLayerPin Dn annotation (extent=[-10, -110; 10, -90]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.35, 
        height=0.49), 
      Documentation(info="This class models the layers between the influent layer (feed_layer) and the lowest layer (bottom_layer)
of an ASM1 secondary clarifier based on Otterpohl.

Hydraulic and sedimentation flux (mass exchange in same direction) with above and underneath layer.

Sedimentation flux is calculated based on two sedimentation velocities
(for macro and micro flocs) and the omega correction function by Haertel.
"), 
      Icon(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Text(extent=[-100, 20; 100, -20], string="%name"), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48)), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, 68; -68, 50; -76, 50; -60, 40; -44, 50; -52, 50; -
              52, 68; -68, 68], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, -40; -68, -58; -76, -58; -60, -68; -44, -58; -52, 
              -58; -52, -40; -68, -40], style(pattern=0, fillColor=69))), 
      Diagram(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48)), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, 68; -68, 50; -76, 50; -60, 40; -44, 50; -52, 50; -
              52, 68; -68, 68], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, -40; -68, -58; -76, -58; -60, -68; -44, -58; -52, 
              -58; -52, -40; -68, -40], style(pattern=0, fillColor=69))));
  equation 
    
    // sink velocity
    vS_F = WWSC.vSfun(X_F, ISV);
    omega = WWSC.omega(z, Xf, hsc, zm, ISV, i);
    
    // sedimentation flux in m-th layer sinking to lower layer
    Jsm_F = if vS_F < Dn.vS_dn_F then omega*(vS_F*X_F) else omega*min(vS_F*X_F
      , Dn.vS_dn_F*Dn.X_dn_F);
    Jsm_S = omega*min(vS_S*X_S, vS_S*Dn.X_dn_S);
    
    // ODE of solid component
    der(X_F) = ((Up.Qr + Up.Qw)/Asc*(Up.X_F - X_F) + Up.SedFlux_F - Jsm_F)/zm;
    der(X_S) = ((Up.Qr + Up.Qw)/Asc*(Up.X_S - X_S) + Up.SedFlux_S - Jsm_S)/zm;
    
    X = X_F + X_S;
    
    // ODEs of soluble components
    der(Si) = (Up.Qr + Up.Qw)*(Up.Si - Si)/(Asc*zm);
    der(Ss) = (Up.Qr + Up.Qw)*(Up.Ss - Ss)/(Asc*zm);
    der(So) = (Up.Qr + Up.Qw)*(Up.So - So)/(Asc*zm);
    der(Sno) = (Up.Qr + Up.Qw)*(Up.Sno - Sno)/(Asc*zm);
    der(Snh) = (Up.Qr + Up.Qw)*(Up.Snh - Snh)/(Asc*zm);
    der(Snd) = (Up.Qr + Up.Qw)*(Up.Snd - Snd)/(Asc*zm);
    der(Salk) = (Up.Qr + Up.Qw)*(Up.Salk - Salk)/(Asc*zm);
    
    // downward connections
    Dn.Qr + Up.Qr = 0;
    Dn.Qw + Up.Qw = 0;
    
    Dn.X_F = X_F;
    Dn.X_S = X_S;
    Dn.SedFlux_F = -Jsm_F;
    Dn.SedFlux_S = -Jsm_S;
    
    Dn.Si = Si;
    Dn.Ss = Ss;
    Dn.So = So;
    Dn.Sno = Sno;
    Dn.Snh = Snh;
    Dn.Snd = Snd;
    Dn.Salk = Salk;
    
    // upward connections
    Up.vS_dn_F = vS_F;
    Up.X_dn_F = X_F;
    Up.X_dn_S = X_S;
  end lower_layer;
  model feed_layer "Influent layer of Otterpohl`s SC model" 
    
    package WWSC = WasteWater.ASM1.SecClar.Otterpohl.Interfaces;
    extends WWSC.SCParam;
    extends WWSC.SCVar;
    WWU.MassConcentration Xf "sludge concentration in clarifier feed";
    SI.Length z "vertical coordinate of current layer";
    parameter SI.Length hsc;
    parameter Integer i "number of layers above feed layer";
    Real omega;
    Real fl;
    
    WWSC.LowerLayerPin Dn annotation (extent=[-10, -110; 10, -90]);
    WWSC.UpperLayerPin Up annotation (extent=[-10, 90; 10, 110]);
    ASM1.Interfaces.WWFlowAsm1in In annotation (extent=[-110, -6; -90, 14]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.35, 
        height=0.49), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Documentation(info="This class models the influent layer of an ASM1 secondary clarifier based on Otterpohl.

It receives the wastewater stream from the biological part (feed).
Hydraulic and sedimentation flux (mass exchange in opposite directions) with above layer
and hydraulic and sedimentation flux (mass exchange in same direction) with underneath layer.

Sedimentation flux is calculated based on two sedimentation velocities
(for macro and micro flocs) and the omega correction function by Haertel.
"), 
      Diagram(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, -40; -68, -58; -76, -58; -60, -68; -44, -58; -52, 
              -58; -52, -40; -68, -40], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, 40; -68, 60; -76, 60; -60, 70; -44, 60; -52, 60; -
              52, 40; -68, 40], style(pattern=0, fillColor=69)), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48))), 
      Icon(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Text(extent=[-100, 20; 100, -20], string="%name"), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, -40; -68, -58; -76, -58; -60, -68; -44, -58; -52, 
              -58; -52, -40; -68, -40], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, 40; -68, 60; -76, 60; -60, 70; -44, 60; -52, 60; -
              52, 40; -68, 40], style(pattern=0, fillColor=69)), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48))));
  equation 
    
    // sink velocity
    vS_F = WWSC.vSfun(X_F, ISV);
    omega = WWSC.omega(z, Xf, hsc, zm, ISV, i);
    fl = (9.4/ISV)*exp(-1.07*Xf/1000);
    
    // sedimentation flux in m-th layer sinking to lower layer
    Jsm_F = if vS_F < Dn.vS_dn_F then omega*(vS_F*X_F) else omega*min(vS_F*X_F
      , Dn.vS_dn_F*Dn.X_dn_F);
    Jsm_S = omega*min(vS_S*X_S, vS_S*Dn.X_dn_S);
    
    // ODE of solid component
    der(X_F) = (In.Q/Asc*Xf*(1 - fl) - (-Up.Qe)/Asc*X_F - (-(Dn.Qr + Dn.Qw))/
      Asc*X_F + Up.SedFlux_F - Jsm_F)/zm;
    der(X_S) = (In.Q/Asc*Xf*fl - (-Up.Qe)/Asc*X_S - (-(Dn.Qr + Dn.Qw))/Asc*X_S
       + Up.SedFlux_S - Jsm_S)/zm;
    
    X = X_F + X_S;
    
    // ODE of soluble components
    der(Si) = (In.Q*In.Si - (-Up.Qe)*Si - (-(Dn.Qr + Dn.Qw))*Si)/(Asc*zm);
    der(Ss) = (In.Q*In.Ss - (-Up.Qe)*Ss - (-(Dn.Qr + Dn.Qw))*Ss)/(Asc*zm);
    der(So) = (In.Q*In.So - (-Up.Qe)*So - (-(Dn.Qr + Dn.Qw))*So)/(Asc*zm);
    der(Sno) = (In.Q*In.Sno - (-Up.Qe)*Sno - (-(Dn.Qr + Dn.Qw))*Sno)/(Asc*zm);
    der(Snh) = (In.Q*In.Snh - (-Up.Qe)*Snh - (-(Dn.Qr + Dn.Qw))*Snh)/(Asc*zm);
    der(Snd) = (In.Q*In.Snd - (-Up.Qe)*Snd - (-(Dn.Qr + Dn.Qw))*Snd)/(Asc*zm);
    der(Salk) = (In.Q*In.Salk - (-Up.Qe)*Salk - (-(Dn.Qr + Dn.Qw))*Salk)/(Asc*
      zm);
    
    // volume flow rates
    In.Q + Up.Qe + Dn.Qr + Dn.Qw = 0;
    
    Dn.SedFlux_F = -Jsm_F;
    Dn.SedFlux_S = -Jsm_S;
    Dn.X_F = X_F;
    Dn.X_S = X_S;
    
    Dn.Si = Si;
    Dn.Ss = Ss;
    Dn.So = So;
    Dn.Sno = Sno;
    Dn.Snh = Snh;
    Dn.Snd = Snd;
    Dn.Salk = Salk;
    
    Up.X_dn_F = X_F;
    Up.X_dn_S = X_S;
    
    Up.Si = Si;
    Up.Ss = Ss;
    Up.So = So;
    Up.Sno = Sno;
    Up.Snh = Snh;
    Up.Snd = Snd;
    Up.Salk = Salk;
    
  end feed_layer;
  model upper_layer "Layer above influent of Otterpohl`s SC" 
    
    package WWSC = WasteWater.ASM1.SecClar.Otterpohl.Interfaces;
    extends WWSC.SCParam;
    extends WWSC.SCVar;
    WWSC.UpperLayerPin Dn annotation (extent=[-10, -110; 10, -90]);
    WWSC.UpperLayerPin Up annotation (extent=[-10, 90; 10, 110]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.35, 
        height=0.49), 
      Documentation(info="This class models the layers between the influent layer (feed_layer) and the effluent layer (top_layer)
of an ASM1 secondary clarifier based on Otterpohl.

Hydraulic and sedimentation flux (mass exchange in opposite directions) with above and underneath layer.

Sedimentation flux is calculated based on two sedimentation velocities
(for macro and micro flocs)."), 
      Icon(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Text(extent=[-100, 20; 100, -20], string="%name"), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, 40; -68, 60; -76, 60; -60, 70; -44, 60; -52, 60; -
              52, 40; -68, 40], style(pattern=0, fillColor=69)), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, -70; -68, -50; -76, -50; -60, -40; -44, -50; -52, 
              -50; -52, -70; -68, -70], style(pattern=0, fillColor=69))), 
      Diagram(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, 40; -68, 60; -76, 60; -60, 70; -44, 60; -52, 60; -
              52, 40; -68, 40], style(pattern=0, fillColor=69)), 
        Polygon(points=[52, 68; 52, 50; 44, 50; 60, 40; 76, 50; 68, 50; 68, 68
              ; 52, 68], style(pattern=0, fillColor=48)), 
        Polygon(points=[-68, -70; -68, -50; -76, -50; -60, -40; -44, -50; -52, 
              -50; -52, -70; -68, -70], style(pattern=0, fillColor=69))));
  equation 
    
    // sink velocity
    vS_F = WWSC.vSfun(X_F, ISV);
    
    // sedimentation flux in m-th layer sinking to lower layer
    Jsm_F = vS_F*X_F;
    Jsm_S = vS_S*X_S;
    
    // ODE of solid component
    der(X_F) = (Dn.Qe/Asc*(Dn.X_dn_F - X_F) + Up.SedFlux_F - Jsm_F)/zm;
    der(X_S) = (Dn.Qe/Asc*(Dn.X_dn_S - X_S) + Up.SedFlux_S - Jsm_S)/zm;
    
    X = X_F + X_S;
    
    // ODEs of soluble components
    der(Si) = Dn.Qe*(Dn.Si - Si)/(Asc*zm);
    der(Ss) = Dn.Qe*(Dn.Ss - Ss)/(Asc*zm);
    der(So) = Dn.Qe*(Dn.So - So)/(Asc*zm);
    der(Sno) = Dn.Qe*(Dn.Sno - Sno)/(Asc*zm);
    der(Snh) = Dn.Qe*(Dn.Snh - Snh)/(Asc*zm);
    der(Snd) = Dn.Qe*(Dn.Snd - Snd)/(Asc*zm);
    der(Salk) = Dn.Qe*(Dn.Salk - Salk)/(Asc*zm);
    
    // downward connection
    Dn.SedFlux_F = -Jsm_F;
    Dn.SedFlux_S = -Jsm_S;
    
    // upward connections
    Up.Qe + Dn.Qe = 0;
    
    Up.X_dn_F = X_F;
    Up.X_dn_S = X_S;
    
    Up.Si = Si;
    Up.Ss = Ss;
    Up.So = So;
    Up.Sno = Sno;
    Up.Snh = Snh;
    Up.Snd = Snd;
    Up.Salk = Salk;
    
  end upper_layer;
  model top_layer "Effluent layer of Otterpohl`s SC model" 
    
    package WWSC = WasteWater.ASM1.SecClar.Otterpohl.Interfaces;
    extends WWSC.SCParam;
    extends WWSC.SCVar;
    extends WWSC.ratios;
    WWSC.UpperLayerPin Dn annotation (extent=[-10, -110; 10, -90]);
    ASM1.Interfaces.WWFlowAsm1out Out annotation (extent=[90, -10; 110, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.35, 
        height=0.49), 
      Documentation(info="This class models the top layer of an ASM1 secondary clarifier based on Otterpohl.

No sedimentation flux (mass exchange) with above but hydraulic and sedimentation flux
(opposite directions) underneath.
From here effluent goes to the receiving water.

Sedimentation flux is calculated based on two sedimentation velocities
(for micro and macro flocs).
"), 
      Icon(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Text(extent=[-100, 20; 100, -20], string="%name"), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-8, 58; -8, 40; 10, 40; 10, 32; 22, 50; 10, 66; 10, 58
              ; -8, 58], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, -70; -68, -50; -76, -50; -60, -40; -44, -50; -52, 
              -50; -52, -70; -68, -70], style(pattern=0, fillColor=69))), 
      Diagram(
        Rectangle(extent=[-100, 100; 100, -100]), 
        Polygon(points=[52, -40; 52, -58; 44, -58; 60, -68; 76, -58; 68, -58; 
              68, -40; 52, -40], style(pattern=0, fillColor=48)), 
        Polygon(points=[-8, 58; -8, 40; 10, 40; 10, 32; 22, 50; 10, 66; 10, 58
              ; -8, 58], style(pattern=0, fillColor=69)), 
        Polygon(points=[-68, -70; -68, -50; -76, -50; -60, -40; -44, -50; -52, 
              -50; -52, -70; -68, -70], style(pattern=0, fillColor=69))));
  equation 
    
    // sink velocity
    vS_F = WWSC.vSfun(X_F, ISV);
    
    // sedimentation flux in m-th layer sinking to lower layer
    Jsm_F = vS_F*X_F;
    Jsm_S = vS_S*X_S;
    
    // ODE of solid component
    der(X_F) = (Dn.Qe/Asc*(Dn.X_dn_F - X_F) - Jsm_F)/zm;
    der(X_S) = (Dn.Qe/Asc*(Dn.X_dn_S - X_S) - Jsm_S)/zm;
    
    X = X_F + X_S;
    
    // ODEs of soluble components
    der(Si) = Dn.Qe*(Dn.Si - Si)/(Asc*zm);
    der(Ss) = Dn.Qe*(Dn.Ss - Ss)/(Asc*zm);
    der(So) = Dn.Qe*(Dn.So - So)/(Asc*zm);
    der(Sno) = Dn.Qe*(Dn.Sno - Sno)/(Asc*zm);
    der(Snh) = Dn.Qe*(Dn.Snh - Snh)/(Asc*zm);
    der(Snd) = Dn.Qe*(Dn.Snd - Snd)/(Asc*zm);
    der(Salk) = Dn.Qe*(Dn.Salk - Salk)/(Asc*zm);
    
    // downward connection
    Dn.SedFlux_F = -Jsm_F;
    Dn.SedFlux_S = -Jsm_S;
    
    // effluent volume flow rate
    Out.Q + Dn.Qe = 0;
    
    // effluent, solid and soluble components (ASM1)
    Out.Si = Si;
    Out.Ss = Ss;
    Out.Xi = rXi*X;
    Out.Xs = rXs*X;
    Out.Xbh = rXbh*X;
    Out.Xba = rXba*X;
    Out.Xp = rXp*X;
    Out.So = So;
    Out.Sno = Sno;
    Out.Snh = Snh;
    Out.Snd = Snd;
    Out.Xnd = rXnd*X;
    Out.Salk = Salk;
  end top_layer;
end Otterpohl;

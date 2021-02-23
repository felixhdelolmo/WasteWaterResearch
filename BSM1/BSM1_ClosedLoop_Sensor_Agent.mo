within BSM1;
model BSM1_ClosedLoop_Sensor_Agent
  //parameter Real avg_start = 0.5;
  //parameter Real avg_period = 14 / 24 / 60;
  constant Real seed = 111234;
  parameter Real plant_start = 1;
  parameter Real plant_period = 14 / 24 / 60;
  final Real gamma = exp(log(0.01) / ceil(30 / plant_period));
  final Real n = 1 / (1 - gamma);
  Real gamma_365 = exp(log(0.01) / ceil(365 / plant_period));
  Real sd(start = mod(16807 * seed, 2147483647)) "status";
  Real rd(start = seed / 2147483647 * 100) "Random number";
  Real sh(start = mod(16807 * seed, 2147483647)) "status";
  Real rh(start = seed / 2147483647 * 100) "Random number";
  Real nh,nh_m,nh_max,nh_measures;
  Boolean visit(start = false);
  constant Integer visits_month = 2 "visits/month of the operator";
  constant Integer visits_measures = 10 "measures taken per visit of the operator";
  Real hour;
  Integer day;
  Real SP;
  constant Real TARIFA_VALLE = 0.073477;
  constant Real TARIFA_LLANO = 0.102651;
  constant Real TARIFA_PUNTA = 0.122547;
  constant Real IVA = 21 + 5;
  Real Electricity_cost;
  constant Real Sludge_cost = 5 "euros/Kg";
  Real PE;
  Real AE;
  Real ME;
  Real EF;
  Real operation_cost_1m;
  Real operation_cost_1y;
  Real Energy;
  /*
  Real EFm;
  Real SPm;
  
  //Real OC;
  Real EQ;
  Real IQ;
  Real Ntotv;
  Real Ntotvm;
  Real CODv;
  Real CODvm;
  Real Snhv;
  Real Snhvm;
  Real TSSv;
  Real TSSvm;
  Real BOD5v;
  Real BOD5vm;
  */
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(Placement(visible = true, transformation(origin = {13.5231,-72.5979}, extent = {{-9.91736,-9.91736},{9.91736,9.91736}}, rotation = 0)));
  WasteWater.ASM1.SludgeSink WasteSludge annotation(Placement(visible = true, transformation(origin = {73.7179,-64.7069}, extent = {{-13.2,-13.2},{13.2,13.2}}, rotation = 0)));
  WasteWater.ASM1.divider2 divider annotation(Placement(visible = true, transformation(origin = {28.8256,2.84698}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  WasteWater.ASM1.nitri tank5(Si(start = 30), Ss(start = 0.889), Xi(start = 1149), Xs(start = 49.3), Xbh(start = 2559), Xba(start = 150), Xp(start = 452), So(start = 0.491), Sno(start = 10.4), Snh(start = 1.73), Snd(start = 0.6879999999999999), Xnd(start = 3.53), Salk(start = 4.13), Kla = 84, V = 1333) annotation(Placement(visible = true, transformation(origin = {1.74327,3.41715}, extent = {{-13.2,-13.2},{13.2,13.2}}, rotation = 0)));
  WasteWater.ASM1.nitri tank4(Si(start = 30), Ss(start = 0.995), Xi(start = 1149), Xs(start = 55.7), Xbh(start = 2559), Xba(start = 150), Xp(start = 451), So(start = 2.43), Sno(start = 9.300000000000001), Snh(start = 2.97), Snd(start = 0.767), Xnd(start = 3.88), Salk(start = 4.29), V = 1333, To = 0.0) annotation(Placement(visible = true, transformation(origin = {-27.758,3.55872}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  WasteWater.ASM1.nitri tank3(Si(start = 30), Ss(start = 1.15), Xi(start = 1149), Xs(start = 64.90000000000001), Xbh(start = 2557), Xba(start = 149), Xp(start = 450), So(start = 1.72), Sno(start = 6.54), Snh(start = 5.55), Snd(start = 0.829), Xnd(start = 4.39), Salk(start = 4.67), V = 1333, To = 0.0) annotation(Placement(visible = true, transformation(origin = {-55.8719,3.55872}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  WasteWater.ASM1.deni tank1(Si(start = 30), Ss(start = 2.81), Xi(start = 1149), Xs(start = 82.09999999999999), Xbh(start = 2552), Xba(start = 148), Xp(start = 449), So(start = 0.0043), Sno(start = 5.37), Snh(start = 7.92), Snd(start = 1.22), Xnd(start = 5.28), Salk(start = 4.93)) annotation(Placement(visible = true, transformation(origin = {-38.8594,27.9724}, extent = {{-13.2,-13.2},{13.2,13.2}}, rotation = 0)));
  WasteWater.ASM1.blower blower2(Q_max = 34574.2654508612) annotation(Placement(visible = true, transformation(origin = {-26.3345,-16.3701}, extent = {{-8.196160000000001,-8.196160000000001},{8.196160000000001,8.196160000000001}}, rotation = 0)));
  WasteWater.ASM1.blower blower3(Q_max = 34574.2654508612) annotation(Placement(visible = true, transformation(origin = {3.20285,-16.726}, extent = {{-8.196160000000001,-8.196160000000001},{8.196160000000001,8.196160000000001}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = 1) annotation(Placement(visible = true, transformation(origin = {-81.1388,-81.8505}, extent = {{-9.015779999999999,-9.015779999999999},{9.015779999999999,9.015779999999999}}, rotation = 0)));
  WasteWater.ASM1.WWSource WWSource annotation(Placement(visible = true, transformation(origin = {-29.8932,76.8683}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  WasteWater.ASM1.WWSignal WWSignal(dir = INF_dir) annotation(Placement(visible = true, transformation(origin = {-69.0391,77.2242}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  WasteWater.ASM1.SecClarModTakacs Settler(S1.X.start = 6394, S1.Si.start = 30, S1.Ss.start = 0.889, S1.So.start = 0.491, S1.Sno.start = 10.4, S1.Snh.start = 1.73, S1.Snd.start = 0.6879999999999999, S1.Salk.start = 4.13, S2.X.start = 356, S2.Si.start = 30, S2.Ss.start = 0.889, S2.So.start = 0.491, S2.Sno.start = 10.4, S2.Snh.start = 1.73, S2.Snd.start = 0.6879999999999999, S2.Salk.start = 4.13, S3.X.start = 356, S3.Si.start = 30, S3.Ss.start = 0.889, S3.So.start = 0.491, S3.Sno.start = 10.4, S3.Snh.start = 1.73, S3.Snd.start = 0.6879999999999999, S3.Salk.start = 4.13, S4.X.start = 356, S4.Si.start = 30, S4.Ss.start = 0.889, S4.So.start = 0.491, S4.Sno.start = 10.4, S4.Snh.start = 1.73, S4.Snd.start = 0.6879999999999999, S4.Salk.start = 4.13, S5.X.start = 356, S5.Si.start = 30, S5.Ss.start = 0.889, S5.So.start = 0.491, S5.Sno.start = 10.4, S5.Snh.start = 1.73, S5.Snd.start = 0.6879999999999999, S5.Salk.start = 4.13, S6.X.start = 356, S6.Si.start = 30, S6.Ss.start = 0.889, S6.So.start = 0.491, S6.Sno.start = 10.4, S6.Snh.start = 1.73, S6.Snd.start = 0.6879999999999999, S6.Salk.start = 4.13, S7.X.start = 69, S7.Si.start = 30, S7.Ss.start = 0.889, S7.So.start = 0.491, S7.Sno.start = 10.4, S7.Snh.start = 1.73, S7.Snd.start = 0.6879999999999999, S7.Salk.start = 4.13, S8.X.start = 29.5, S8.Si.start = 30, S8.Ss.start = 0.889, S8.So.start = 0.491, S8.Sno.start = 10.4, S8.Snh.start = 1.73, S8.Snd.start = 0.6879999999999999, S8.Salk.start = 4.13, S9.X.start = 18.1, S9.Si.start = 30, S9.Ss.start = 0.889, S9.So.start = 0.491, S9.Sno.start = 10.4, S9.Snh.start = 1.73, S9.Snd.start = 0.6879999999999999, S9.Salk.start = 4.13, S10.X.start = 12.5, S10.Si.start = 30, S10.Ss.start = 0.889, S10.So.start = 0.491, S10.Sno.start = 10.4, S10.Snh.start = 1.73, S10.Snd.start = 0.6879999999999999, S10.Salk.start = 4.13) annotation(Placement(visible = true, transformation(origin = {66.6767,26.1501}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = 20, uMin = 0.1) annotation(Placement(visible = true, transformation(origin = {32.7402,68.3274}, extent = {{-6.77369,-6.77369},{6.77369,6.77369}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(Placement(visible = true, transformation(origin = {45.5516,90.7473}, extent = {{-8.196160000000001,-8.196160000000001},{8.196160000000001,8.196160000000001}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI2(k = 0.828, T = 0.02) annotation(Placement(visible = true, transformation(origin = {68.6833,91.1032}, extent = {{-7.45106,-7.45106},{7.45106,7.45106}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback2 annotation(Placement(visible = true, transformation(origin = {46.9751,46.6192}, extent = {{-7.45106,-7.45106},{7.45106,7.45106}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI1(k = 0.833, T = 0.042) annotation(Placement(visible = true, transformation(origin = {68.3274,55.516}, extent = {{-8.196160000000001,-8.196160000000001},{8.196160000000001,8.196160000000001}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant NitrogenSetpoint(k = 1) annotation(Placement(visible = true, transformation(origin = {12.8114,90.0356}, extent = {{-7.45106,-7.45106},{7.45106,7.45106}}, rotation = 0)));
  WasteWater.ASM1.sensor_class_B sensor_class_b1 annotation(Placement(visible = true, transformation(origin = {7.22892,68.4337}, extent = {{-7.45106,-7.45106},{7.45106,7.45106}}, rotation = 0)));
  WasteWater.ASM1.sensor_O2 sensor_O2 annotation(Placement(visible = true, transformation(origin = {17.8819,22.6498}, extent = {{-8.196160000000001,-8.196160000000001},{8.196160000000001,8.196160000000001}}, rotation = 0)));
  WasteWater.ASM1.sensor_class_A sensor_class_a1 annotation(Placement(visible = true, transformation(origin = {36.1446,29.8795}, extent = {{-5.59809,-5.59809},{5.59809,5.59809}}, rotation = 0)));
  WasteWater.ASM1.KLA_dynamics kla_dynamics1 annotation(Placement(visible = true, transformation(origin = {26.0241,-17.3494}, extent = {{7.45106,7.45106},{-7.45106,-7.45106}}, rotation = -180)));
  WasteWater.ASM1.mixer3 mixer annotation(Placement(visible = true, transformation(origin = {-73.90300000000001,26.1201}, extent = {{-14.52,-14.52},{14.52,14.52}}, rotation = 0)));
  WasteWater.ASM1.blower blower1(Q_max = 34574.2654508612) annotation(Placement(visible = true, transformation(origin = {-54.4484,-16.3701}, extent = {{-9.015779999999999,-9.015779999999999},{9.015779999999999,9.015779999999999}}, rotation = 0)));
  WasteWater.ASM1.pump pump2(Q_max = 385) annotation(Placement(visible = true, transformation(origin = {72.2891,-9.15663}, extent = {{12,12},{-12,-12}}, rotation = 0)));
  WasteWater.ASM1.ADsensor_Q ADsensor_Return annotation(Placement(visible = true, transformation(origin = {8.4072,-45.3887}, extent = {{12,12},{-12,-12}}, rotation = 0)));
  WasteWater.ASM1.ADsensor_Q ADsensor_Recycle annotation(Placement(visible = true, transformation(origin = {-8.71927,-29.8486}, extent = {{12,12},{-12,-12}}, rotation = 0)));
  WasteWater.ASM1.ADsensor_Q ADsensor_Waste annotation(Placement(visible = true, transformation(origin = {55.8603,-42.1291}, extent = {{-12,12},{12,-12}}, rotation = -90)));
  WasteWater.ASM1.ADsensor_Q ADsensor_Influent annotation(Placement(visible = true, transformation(origin = {-45.3941,53.4049}, extent = {{10,10},{-10,-10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput operation_cost annotation(Placement(visible = true, transformation(origin = {110.581,79.90300000000001}, extent = {{-8.9916,-8.9916},{8.9916,8.9916}}, rotation = 0), iconTransformation(origin = {110.504,60.5042}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  WasteWater.ASM1.deni tank2(Si(start = 30), Ss(start = 1.46), Xi(start = 1149), Xs(start = 76.40000000000001), Xbh(start = 2553), Xba(start = 148), Xp(start = 450), So(start = 6.31e-05), Sno(start = 3.66), Snh(start = 8.34), Snd(start = 0.882), Xnd(start = 5.03), Salk(start = 5.08)) annotation(Placement(visible = true, transformation(origin = {-8.83405,28.7419}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  WasteWater.ASM1.sensor_NO sensor_NO annotation(Placement(visible = true, transformation(origin = {-12.4811,43.3625}, extent = {{-8.196160000000001,-8.196160000000001},{8.196160000000001,8.196160000000001}}, rotation = 0)));
  .Agent agent annotation(Placement(visible = true, transformation(origin = {25.6462,49.1801}, extent = {{-7.85515,-7.85515},{7.85515,7.85515}}, rotation = 0)));
  WasteWater.ASM1.EffluentSink Effluent annotation(Placement(visible = true, transformation(origin = {119.952,-27.6316}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  WasteWater.ASM1.ADsensor_Q ADsensor_Effluent annotation(Placement(visible = true, transformation(origin = {101.739,13.7528}, extent = {{-12,-12},{12,12}}, rotation = -90)));
  WasteWater.ASM1.pump ReturnPump(Q_max = 18446) annotation(Placement(visible = true, transformation(origin = {-60.1996,-51.8583}, extent = {{15.972,15.972},{-15.972,-15.972}}, rotation = 0)));
  WasteWater.ASM1.pump RecyclePump(Q_min = 0.0, Q_max = 55338) annotation(Placement(visible = true, transformation(origin = {-80.02160000000001,-36.0186}, extent = {{12,12},{-12,-12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Temperature(k = 15) annotation(Placement(visible = true, transformation(origin = {-113.844,40.3944}, extent = {{-9.91736,-9.91736},{9.91736,9.91736}}, rotation = 0)));
  BSM1.RandomWeatherPulse randomweatherpulse1(startTime = 112) annotation(Placement(visible = true, transformation(origin = {-116.273,76.8873}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(randomweatherpulse1.y,agent.weather) annotation(Line(points = {{-105.273,76.8873},{-94.1176,76.8873},{-94.1176,49.1597},{17.2269,49.1597},{17.2269,49.1597}}));
  //connect(randomweatherpulse1.y,agent.weather) annotation(Line(points = {{-105.273,76.8873},{-94.958,76.8873},{-94.958,49.1597},{16.9839,49.1597},{16.9839,49.9172}}));
  connect(randomweatherpulse1.y,WWSignal.u) annotation(Line(points = {{-105.273,76.8873},{-83.1431,76.8873},{-83.1431,76.1348},{-83.1431,76.1348}}));
  connect(operation_cost,agent.oc) annotation(Line(points = {{110.581,79.90300000000001},{52.9412,79.90300000000001},{52.9412,55.042},{34.0336,55.042},{34.0336,55.042}}));
  connect(Temperature.y,tank5.T) annotation(Line(points = {{-102.935,40.3944},{-11.1495,40.3944},{-11.1495,8.919560000000001},{-11.1495,8.919560000000001}}));
  connect(Temperature.y,tank2.T) annotation(Line(points = {{-102.935,40.3944},{-22.2989,40.3944},{-22.2989,33.7669},{-22.2989,33.7669}}));
  connect(Temperature.y,tank1.T) annotation(Line(points = {{-102.935,40.3944},{-53.1988,40.3944},{-53.1988,32.8112},{-53.1988,32.8112}}));
  connect(Temperature.y,tank4.T) annotation(Line(points = {{-102.935,40.3944},{-38.8638,40.3944},{-38.8638,8.282450000000001},{-38.8638,8.282450000000001}}));
  connect(Temperature.y,tank3.T) annotation(Line(points = {{-102.935,40.3944},{-66.8967,40.3944},{-66.8967,8.60101},{-66.8967,8.60101}}));
  connect(PI2.y,RecyclePump.u) annotation(Line(points = {{76.87949999999999,91.1032},{97.15300000000001,91.1032},{97.15300000000001,-93.9502},{-34.1637,-93.9502},{-34.1637,-38.4342},{-43.5046,-38.5401},{-69.7801,-38.5401}}));
  connect(RecyclePump.Out,mixer.In2) annotation(Line(points = {{-88.6057,-38.3318},{-87.2289,-38.3318},{-87.2289,23.6145},{-83.7208,23.6145},{-83.7208,23.7432}}));
  connect(ADsensor_Recycle.Out,RecyclePump.In) annotation(Line(points = {{-19.4813,-30.8379},{-46.2651,-30.8379},{-71.6965,-34.8277},{-71.6965,-34.3175}}));
  connect(constant1.y,ReturnPump.u) annotation(Line(points = {{24.4322,-72.5979},{34.2169,-72.5979},{34.2169,-89.1566},{-38.1983,-89.1566},{-38.1983,-59.0464},{-42.9968,-55.2144},{-46.5682,-55.2144}}));
  connect(ReturnPump.Out,mixer.In3) annotation(Line(points = {{-71.625,-54.9371},{-94.45780000000001,-54.9371},{-94.45780000000001,26.988},{-83.5658,26.988},{-83.5658,26.7402}}));
  connect(ADsensor_Return.Out,ReturnPump.In) annotation(Line(points = {{-2.35478,-46.378},{-41.4458,-46.378},{-49.1189,-52.9105},{-49.1189,-49.5941}}));
  connect(ADsensor_Effluent.Out,Effluent.In) annotation(Line(points = {{102.728,2.99079},{102.728,-25},{108.906,-25},{108.906,-24.8557}}));
  connect(Settler.Effluent,ADsensor_Effluent.In) annotation(Line(points = {{76.20650000000001,31.2693},{93.5943,31.2693},{102.728,30.5584},{102.728,24.8537}}));
  connect(sensor_class_a1.y,agent.o2) annotation(Line(points = {{42,30},{42,38},{6,38},{6,42.4485},{14.5394,42.4485}}, color = {0,0,127}));
  connect(limiter1.y,agent.nh) annotation(Line(points = {{40.1913,68.3274},{46.8938,68.3274},{46.8938,59.6221},{8.373889999999999,59.6221},{8.373889999999999,56.2725},{22.1752,54.624},{14.5394,54.624}}));
  connect(agent.y,feedback2.u1) annotation(Line(points = {{32.6063,48.3398},{40.8646,48.3398},{40.8646,47.2287},{40.8646,47.2287}}));
  connect(tank2.MeasurePort,sensor_NO.In) annotation(Line(points = {{-4.04383,34.3587},{-3.55872,34.3587},{-3.55872,38.79},{-8.896800000000001,38.79},{-12.7558,42.6548},{-12.7558,37.6187}}));
  connect(sensor_NO.Sno,sensor_class_b1.u) annotation(Line(points = {{-4.70331,44.0972},{-2.89157,44.0972},{-2.89157,68.4337},{-1.71235,68.4337}}));
  connect(tank2.Out,tank3.In) annotation(Line(points = {{2.14681,28.0809},{11.032,28.0809},{11.032,19.2171},{-76.5125,19.2171},{-76.5125,3.20285},{-66.80200000000001,3.20285},{-66.80200000000001,3.09607}}));
  connect(tank1.Out,tank2.In) annotation(Line(points = {{-26.7805,27.2452},{-18.8612,27.2452},{-19.8024,26.9697},{-19.8024,28.3095}}));
  connect(ADsensor_Influent.Out,mixer.In1) annotation(Line(points = {{-54.3624,52.5805},{-85.9846,52.5805},{-85.9846,30.3265},{-82.7735,30.3265},{-82.7735,30.3265}}));
  connect(WWSource.Out,ADsensor_Influent.In) annotation(Line(points = {{-21.6085,70.67610000000001},{-21.4069,70.67610000000001},{-21.4069,52.0902},{-36.3918,52.0902},{-36.3918,52.0902}}));
  connect(ADsensor_Waste.Out,WasteSludge.In) annotation(Line(points = {{54.871,-52.8911},{54.871,-53.1716},{55.0621,-64.8588},{60.9901,-64.5783},{60.9901,-64.934}}));
  connect(pump2.Out,ADsensor_Waste.In) annotation(Line(points = {{63.7051,-11.4698},{54.9398,-11.4698},{54.871,-31.3087},{54.871,-31.0282}}));
  connect(ADsensor_Recycle.In,divider.Out1) annotation(Line(points = {{2.38167,-30.8379},{33.452,-30.8379},{33.452,-20.9964},{45.5516,-20.9964},{45.5516,2.13523},{39.1601,2.13523},{39.1601,1.90748}}));
  connect(Settler.Return,ADsensor_Return.In) annotation(Line(points = {{64.88979999999999,16.9775},{51.411,16.9775},{51.411,-27.3276},{38.6426,-27.3276},{38.6426,-45.7677},{19.5081,-46.378},{19.5081,-46.378}}));
  connect(constant1.y,pump2.u) annotation(Line(points = {{24.4322,-72.5979},{34.2169,-72.5979},{34.2169,-89.1566},{93.494,-89.1566},{93.494,-31.8072},{82.53060000000001,-11.6782},{82.53060000000001,-11.6782}}));
  connect(Settler.Waste,pump2.In) annotation(Line(points = {{71.8933,16.6216},{80.4819,16.6216},{80.6142,-7.45555},{80.6142,-7.45555}}));
  connect(kla_dynamics1.y,blower3.u) annotation(Line(points = {{17.8279,-17.3494},{9.63855,-17.3494},{9.63855,-18.8831},{10.5292,-18.8831}}));
  connect(PI1.y,kla_dynamics1.u) annotation(Line(points = {{77.3432,55.516},{89.1566,55.516},{89.1566,-19.2771},{36.6265,-19.2771},{36.6265,-16.3855},{34.9654,-16.3855},{34.9654,-17.3494}}));
  connect(sensor_class_a1.y,feedback2.u2) annotation(Line(points = {{42.3025,29.8795},{47.2289,29.8795},{47.2289,40.6584},{46.9751,40.6584}}));
  connect(sensor_class_a1.u,sensor_O2.So) annotation(Line(points = {{29.4269,29.8795},{25.0602,29.8795},{25.0602,23.3055},{25.6992,23.3055}}));
  connect(tank5.MeasurePort,sensor_O2.In) annotation(Line(points = {{6.95965,9.65136},{6.40569,9.65136},{6.40569,14.5907},{16.0802,14.5907},{16.0802,16.906},{17.5677,16.906}}));
  connect(sensor_class_b1.y,limiter1.u) annotation(Line(points = {{15.4251,68.4337},{24.0964,68.4337},{24.0964,68.3274},{24.6118,68.3274}}));
  connect(NitrogenSetpoint.y,feedback1.u1) annotation(Line(points = {{21.0075,90.0356},{38.0783,90.0356},{38.0783,90.7473},{38.9947,90.7473}}));
  connect(feedback2.y,PI1.u) annotation(Line(points = {{53.6811,46.6192},{56.9395,46.6192},{56.9395,55.1601},{58.492,55.1601},{58.492,55.516}}));
  connect(feedback1.y,PI2.u) annotation(Line(points = {{52.9281,90.7473},{59.0747,90.7473},{59.0747,91.1032},{59.742,91.1032}}));
  connect(limiter1.y,feedback1.u2) annotation(Line(points = {{40.1913,68.3274},{46.6192,68.3274},{46.6192,83.9858},{45.5516,83.9858},{45.5516,84.1904}}));
  connect(divider.Out2,Settler.Feed) annotation(Line(points = {{39.0747,4.51246},{45.5516,4.51246},{45.5516,27.7249},{57.0748,27.7249}}));
  connect(WWSignal.y[1],WWSource.u[1]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[2],WWSource.u[2]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[3],WWSource.u[3]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[4],WWSource.u[4]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[5],WWSource.u[5]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[6],WWSource.u[6]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[7],WWSource.u[7]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[8],WWSource.u[8]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[9],WWSource.u[9]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[10],WWSource.u[10]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[11],WWSource.u[11]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[12],WWSource.u[12]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[13],WWSource.u[13]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(WWSignal.y[14],WWSource.u[14]) annotation(Line(points = {{-55.8391,77.2242},{-44.9477,77.2242},{-44.9477,77.0035},{-44.9477,77.0035}}));
  connect(constant2.y,blower2.u) annotation(Line(points = {{-71.2214,-81.8505},{-39.5018,-81.8505},{-39.5018,-24.5552},{-15.6584,-24.5552},{-15.6584,-18.1495},{-19.0082,-18.1495},{-19.0082,-18.5272}}));
  connect(constant2.y,blower1.u) annotation(Line(points = {{-71.2214,-81.8505},{-39.8577,-81.8505},{-39.8577,-18.1495},{-46.7453,-18.1495},{-46.7453,-18.7429}}));
  connect(tank5.AirIn,blower3.AirOut) annotation(Line(points = {{1.93411,-6.0614},{2.13523,-6.0614},{2.13523,-11.1193},{2.0963,-11.1193}}));
  connect(tank4.AirIn,blower2.AirOut) annotation(Line(points = {{-27.5845,-5.05814},{-27.4021,-5.05814},{-27.4021,-10.7634},{-27.4411,-10.7634}}));
  connect(tank3.AirIn,blower1.AirOut) annotation(Line(points = {{-55.6984,-5.05814},{-55.8719,-5.05814},{-55.8719,-10.2027},{-56.0215,-10.2027}}));
  connect(mixer.Out,tank1.In) annotation(Line(points = {{-62.38,26.4818},{-51.0843,26.4818},{-51.0843,27.4967},{-50.9246,27.4967}}));
  connect(tank4.Out,tank5.In) annotation(Line(points = {{-16.6544,3.09607},{-11.032,3.09607},{-11.032,2.90823},{-10.2799,2.90823}}));
  connect(tank3.Out,tank4.In) annotation(Line(points = {{-44.7683,3.09607},{-38.79,3.09607},{-38.79,3.09607},{-38.6881,3.09607}}));
  connect(tank5.Out,divider.In) annotation(Line(points = {{13.9572,2.90824},{21.7082,2.90824},{21.7082,3.23132},{20.242,3.23132}}));
  connect(divider.Out2,Settler.Feed) annotation(Line(points = {{39.0747,4.51246},{45.5516,4.51246},{45.5516,28.0807},{60.2777,28.0807}}));
equation
  /*when initial() then
      TSS_start = tank1.TSS + tank2.TSS + tank3.TSS + tank4.TSS + tank5.TSS + 
        Settler.TSS;
    end when;
    */
  /*when sample(plant_start, plant_period) then
    
 
      Energy = gamma * pre(Energy) + (AE + PE + ME) / n;
    EFm = gamma * pre(EFm) + EF / n;
    SPm = gamma * pre(SPm) + SP / n;
    operation_cost_1m = gamma * pre(operation_cost_1m) + (1 - gamma) * operation_cost;
    operation_cost_1y = gamma_365 * pre(operation_cost_1y) + (1 - gamma_365) * operation_cost;
    EQ = ADsensor_Effluent.EQ;
    IQ = ADsensor_Influent.IQ;
    Ntotv = ADsensor_Effluent.Ntotv;
    Ntotvm = ADsensor_Effluent.Ntotvm;
    CODv = ADsensor_Effluent.CODv;
    CODvm = ADsensor_Effluent.CODvm;
    Snhv = ADsensor_Effluent.Snhv;
    Snhvm = ADsensor_Effluent.Snhvm;
    TSSv = ADsensor_Effluent.TSSv;
    TSSvm = ADsensor_Effluent.TSSvm;
    BOD5v = ADsensor_Effluent.BOD5v;
    BOD5vm = ADsensor_Effluent.BOD5vm;

end when;
*/
  when sample(1, 1) then
      sd = mod(16807 * pre(sd), 2147483647);
    rd = sd / 2147483647;
    if visit == false and rd < visits_month / 31.0 then
      visit = true;
    else
      visit = false;
    end if;
  
  end when;
  when sample(plant_start, plant_period) then
      sh = mod(16807 * pre(sh), 2147483647);
    rh = sh / 2147483647;
    operation_cost_1m = gamma * pre(operation_cost_1m) + (1 - gamma) * operation_cost;
    operation_cost_1y = gamma_365 * pre(operation_cost_1y) + (1 - gamma_365) * operation_cost;
    if visit == true and hour > 9 and hour < 15 and rh < visits_measures / floor((15 - 9) / 24.0 / plant_period) then
      nh_max = max(Effluent.In.Snh, pre(nh_max));
      nh = pre(nh) + Effluent.In.Snh;
      nh_measures = pre(nh_measures) + 1;
      nh_m = nh / max(1, nh_measures);
    elseif visit == true and hour > 21 then
      nh_max = 0;
      nh = 0;
      nh_measures = 0;
      nh_m = 0;
    else
      nh_max = pre(nh_max);
      nh = pre(nh);
      nh_measures = pre(nh_measures);
      nh_m = nh / max(1, nh_measures);
    end if;
    EF = if visit == true and hour > 18 and hour < 18.5 and pre(EF) < 10 then (if nh_m > 6 then 50000 else 0) + (if nh_max > 10 then 80000 else 0) else 0;
  
  end when;
  //EF = pre(EF) + 1;
  //EF = pre(EF) + 60000;
  //EF = pre(EF);
  //EF = pre(EF);
  // and hour < 18 and r < 20 / floor((18 - 9) / 24 / plant_period) then
  //EF = ADsensor_Effluent.EF_NH + ADsensor_Effluent.EF_TN;
  day = floor(time);
  hour = 24 * (time - day);
  Energy = AE + PE + ME;
  // if visit_communication == true then 50000 else 0;
  Electricity_cost = (1 + IVA / 100) * (if hour >= 8 and hour < 18 then TARIFA_LLANO else if hour >= 18 and hour < 22 then TARIFA_PUNTA else if hour >= 22 then TARIFA_LLANO else TARIFA_VALLE);
  operation_cost = Electricity_cost * Energy + EF + Sludge_cost * SP;
  SP = ADsensor_Waste.TSS / 1000;
  PE = 0.004 * ADsensor_Recycle.Out.Q + 0.008 * ADsensor_Return.Out.Q + 0.05 * ADsensor_Waste.Out.Q;
  AE = tank3.AE + tank4.AE + tank5.AE;
  ME = tank1.ME + tank2.ME;
  //OC = gamma1 * (AE + PE + ME) + gamma2 * SP + EF / 10;
  //OC_plant.signal[1] = OC;
  //TSS = tank1.TSS + tank2.TSS + tank3.TSS + tank4.TSS + tank5.TSS + Settler.TSS;
  /*
      if (time == agent_start) then
        SP = TSS + ADsensor_Waste.TSS;
      else
        SP = TSS - pre(TSS) + ADsensor_Waste.TSS;
      end if;
       */
  //SP = ((TSS - TSS_start) + ADsensor_Waste.TSS)/1000;
  //OCI = AE + PE + 5*SPm3 + 3*0 + ME;
  //gamma1 = 0.1*floor(time/(3*28));
  //annotation(experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06));
  annotation(experiment(StartTime = 0, StopTime = 2100, Tolerance = 0.001));
end BSM1_ClosedLoop_Sensor_Agent;


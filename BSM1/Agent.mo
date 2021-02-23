within BSM1;
model Agent
  extends Modelica.Blocks.Interfaces.SO;
  parameter Real agent_start = 1;
  parameter Real agent_period = 14 / 60 / 24;
  Modelica.Blocks.Interfaces.RealInput o2 annotation(Placement(visible = true, transformation(origin = {-120,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-120,-75}, extent = {{-20,-20},{20,20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput nh annotation(Placement(visible = true, transformation(origin = {-100.282,59.7183}, extent = {{-10.2817,-10.2817},{10.2817,10.2817}}, rotation = 0), iconTransformation(origin = {-120,80}, extent = {{-19.375,-19.375},{19.375,19.375}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput oc annotation(Placement(visible = true, transformation(origin = {-142.017,19.7479}, extent = {{-10,-10},{10,10}}, rotation = -90), iconTransformation(origin = {-111.367,7.30956}, extent = {{10,-10},{-10,10}}, rotation = 180)));
  Integer a;
equation
  when sample(agent_start, agent_period) then
      a = na(5);
  
  end when;
  y = 2 + a annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Polygon(origin = {1.03214,1.38434}, fillColor = {0,85,255}, fillPattern = FillPattern.CrossDiag, points = {{-26.9431,45.9841},{0.587292,52.057},{57.6723,8.737109999999999},{-42.3277,-52.8013},{42.2877,-49.1576},{-57.3074,6.30797},{-49.6151,36.6723},{11.5185,-9.48151},{-9.53417,31.814},{-9.53417,31.4092},{-29.7771,37.4821},{-27.7528,53.6764},{-26.9431,45.9841}}),Bitmap(extent = {{11.7409,19.4332},{-5.26316,27.1255}})}));
end Agent;


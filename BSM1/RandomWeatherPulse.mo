within BSM1;
model RandomWeatherPulse "Generate a random pulse signals of type Real"
  extends Modelica.Blocks.Interfaces.SO;
  parameter Real seed; 
  parameter Real rain = 20 "% of rain";
  parameter Real storm = 10 "% of storm";
  parameter Real period = 14 "Times for one period";
  parameter Real startTime = 100 "Output = offset for time < startTime";
protected
  final Real p_offset = -1;
  final Real p_startTime = startTime;
  Real p_amplitude(start = 0) "Amplitudes of pulse";
  Real s(start = mod(16807 * seed, 2147483647)) "status";
  Real r(start = seed / 2147483647 * 100) "Random number";
equation
  when sample(startTime, period) then
      s = mod(16807 * pre(s), 2147483647);
    r = s / 2147483647 * 100;
    p_amplitude = if r < storm then 3 else if r >= storm and r < storm + rain then 2 else 1;
  
  end when;
  y = p_offset + (if time < p_startTime then 0 else p_amplitude) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Line(origin = {8.035500000000001,10.9036}, points = {{-83.38760000000001,-45.4106},{-49.5848,-44.7064},{-50.9932,45.4344},{-15.782,42.6175},{-23.5285,-40.4811},{8.16168,-37.6642},{1.82366,21.4908},{25.7673,5.29359},{28.5842,-31.3261},{59.5701,-35.5515},{61.6828,1.06824},{81.4011,-8.086690000000001},{75.76730000000001,-42.5937},{74.35890000000001,-44.0022},{82.8096,-42.5937}})}));
end RandomWeatherPulse;


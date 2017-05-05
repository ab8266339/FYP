%P2B Phase to Bearing
%   sin(2*pi*phase*t)
function bearing = P2B(t,Phase)

bearing = sin(2*pi*30*t+deg2rad(Phase));

end


freq = 9e9;
df = 400.0;
lambda = physconst('LightSpeed')/freq;
speed = dop2speed(df,lambda)
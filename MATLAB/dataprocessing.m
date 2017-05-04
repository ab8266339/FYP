%yam=amdemod(INNor,1e6,125e6);
%yfm=fmdemod(INNor,1e6,125e6,480);
s=125e6;
yam=amdemod(INNor,1e6,125e6);
yfm=fmdemod(INNor,1e6,125e6,480);
yamf=filter30hz125e6(yam);
yfmf=filter30hz125e6(yfm);


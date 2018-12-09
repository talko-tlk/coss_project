function [sig] = sigmoidal(alfa,theta,y)
%signoidal function,y-independent variable;sig-dependent variable
sig=(1-exp(-alfa*y))./(1+exp(-alfa*(y-theta)));
%figure(2)
%plot(y,sig)
% title('sigmoidal function')
% xlabel('y')
% ylabel('sig')
% grid on
end


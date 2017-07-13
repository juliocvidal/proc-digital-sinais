clear; 
clc;
N=input('Comprimento da Janela:'); 
w=bartlett(N)
wvtool(w)
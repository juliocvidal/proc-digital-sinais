close all;
clear all;
clc;
Wn = [0.5 0.8];       
N = 17;  %Se aumentar esse valor o filtro melhora consideravelmente         
Ws = 8000;

% Resposta janela hanning

%###########################IMPORTANTE##############################
%quando eu chegar do trabalho eu vejo como ficou o restante com vcs
%para modificar as janelas, basta mudar o parametro de hanning para
%rectwin, por exemplo
BM = fir1((N-1),Wn,'stop',hanning(N));
%Calculos para Resposta em Freqüência
%Hanning
[Hr,wr] = freqz(BM,1);
%Gráficos modulo/fase para janela hanning
figure(1);
subplot(2,1,1);
%Gráfico de modulo Db x Hz
plot(wr*Ws/(2*pi),20*log10(abs(Hr)));
grid minor;
title('Filtro Rejeita-faixa Janela Hanning - Resposta em Frequência');
xlabel('Hertz');
ylabel('(dB)'); 
%Gráfico de fase graus x Hz
subplot(2,1,2);
plot(wr*Ws/(2*pi),angle(Hr)*180/pi);grid minor;
xlabel('Hertz'); 
ylabel('Fase (graus)'); 

%Teste do Filtro
%Frequências para as senóides
freq1=1000;
freq2=2000;
freq3=2500;
freq4=2600;
freq5=2700;
freq6=2800;
freq7=3000;
 
%Base de tempo para os sinais senoidais
t = (1:800)/Ws;  

%Sinais Senoidais Individuais
sin1 = sin(2*pi*freq1*t);
sin2 = sin(2*pi*freq2*t);
sin3 = sin(2*pi*freq3*t);
sin4 = sin(2*pi*freq4*t);
sin5 = sin(2*pi*freq5*t);
sin6 = sin(2*pi*freq6*t);
sin7 = sin(2*pi*freq7*t);
 
%Geração dos Sinal Multisenoidal através da soma das várias senóides
MultiSenoidal=sin1+sin2+sin3+sin4+sin5+sin6+sin7;

% Filtragem dos sinais

% MultiSenoidal Filtrado: janela hanning
MFBM = filter(BM,1,MultiSenoidal); 

% Resposta Temporal
t=((1:800)/Ws)*1000;
figure(2);
%antes da filtragem
subplot(2,1,1);
plot(t,MultiSenoidal);
grid on;
title('Sinal MultiSenoidal - Resposta Temporal');
%depois da filtragem
subplot(2,1,2);
plot(t,MFBM); grid on;
title('Janela Hanning do Sinal Filtrado');
 
 
%Resposta em Freqüência
%Módulo da transformada de Fourier para sinais
MTFSM = abs(fft(MultiSenoidal)); %Original
MTFSMFR = abs(fft(MFBM)); %Janela Hanning          
f = Ws*(0:399)/800; 
figure(3);
subplot(2,1,1);
plot(f,MTFSM(1:400)); 
grid minor;
title('Sinal Multisenoidal - Resposta em Freqüência');
%depois da filtragem, verifiquem que na faixa de frequencia entre 2kHz e
%3kHz o sinal é atenuado
subplot(2,1,2);
plot(f,MTFSMFR(1:400)); 
grid minor;
title('Janela Hanning do Sinal filtrado');
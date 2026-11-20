%EEET425 LAB09 q1a

%part a residuez forward, H(z) to residues and poles
b = [-2 5.65 -2.88]; %numerator coefficients
a = [1 -0.1 0.09 0.648]; %denominator coefficients
[r, p, k] = residuez(b, a) %k is empty since order of num < order of den

ic = find(abs(imag(p)) > 1e-6); %indices of the complex conjugate poles
ir = find(abs(imag(p)) <= 1e-6); %index of the real pole

%part a residuez backward on the complex pair, gives the real second order section
[b_sec, a_sec] = residuez(r(ic), p(ic), []);
b_sec = real(b_sec) %should be [2 0.45]
a_sec = real(a_sec) %should be [1 -0.9 0.81]

%part a residuez backward on the real pole, gives the first order section
[b_fo, a_fo] = residuez(r(ir), p(ir), []);
b_fo = real(b_fo) %should be -4
a_fo = real(a_fo) %should be [1 0.8]

%part c 3D mesh of |H(z)|
[X, Y] = meshgrid(linspace(-1, 1, 100)); %even number of points so z = 0 is skipped
Z = X + 1j*Y; %complex z plane grid
H = (-2 + 5.65*Z.^-1 - 2.88*Z.^-2) ./ (1 - 0.1*Z.^-1 + 0.09*Z.^-2 + 0.648*Z.^-3);
Hmag = abs(H);
Hmag(Hmag > 30) = 30; %clip the spikes at the poles so the plot is readable

figure;
mesh(X, Y, Hmag);
title('|H(z)| 3D Mesh'); xlabel('Re(z)'); ylabel('Im(z)'); zlabel('|H(z)|');

%part d 2D pole zero plot
figure;
zplane(b, a);
title('Pole-Zero Plot of H(z)');

%part e input signal from lab 04
n = 0:200; %time index
x = sin(pi*n/3) + 5*cos(0.95*pi*n); %input signal
y = filter(b, a, x); %output of the LTI system

figure;
subplot(2, 1, 1);
stem(n, x, 'filled'); %input signal

subplot(2, 1, 2);
stem(n, y, 'filled'); %output signal

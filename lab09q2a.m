%%EEET425 LAB 09 q2a

b = [5 11.2 5.44 -0.384 -2.3552 -1.2288]; %numerator coefficients
a = [1 0.8 0 -0.512 -0.4096]; %denominator coefficients

%part a residuez forward, H(z) to residues, poles, and direct terms
[r, p, k] = residuez(b, a) %k = [2 3] since num order (5) > den order (4)
abs(p) %all pole magnitudes are 0.8, so the system is stable

ic = find(abs(imag(p)) > 1e-6); %indices of the complex conjugate poles
ir = find(abs(imag(p)) <= 1e-6); %indices of the two real poles

%part a residuez backward on the complex pair, gives a real second order section
[b_c, a_c] = residuez(r(ic), p(ic), []);
b_c = real(b_c) %should be [1 2]
a_c = real(a_c) %should be [1 0.8 0.64]

%part a residuez backward on the real poles, gives the other second order section
[b_r, a_r] = residuez(r(ir), p(ir), []);
b_r = real(b_r) %should be [2 3]
a_r = real(a_r) %should be [1 0 -0.64]

%part c 3D mesh of |H(z)|
[X, Y] = meshgrid(linspace(-1, 1, 100)); %even number of points so z = 0 is skipped
Z = X + 1j*Y; %complex z plane grid
H = (5 + 11.2*Z.^-1 + 5.44*Z.^-2 - 0.384*Z.^-3 - 2.3552*Z.^-4 - 1.2288*Z.^-5) ./ (1 + 0.8*Z.^-1 - 0.512*Z.^-3 - 0.4096*Z.^-4);
Hmag = abs(H);
Hmag(Hmag > 30) = 30; %clip the spikes at the poles so the plot is readable

figure;
mesh(X, Y, Hmag);
title('|H(z)| 3D Mesh'); xlabel('Re(z)'); ylabel('Im(z)'); zlabel('|H(z)|');

%part d 2D pole zero plot
figure;
zplane(b, a);
title('Pole-Zero Plot of H(z)');

%part e magnitude and phase response
[Hw, w] = freqz(b, a, 1024); %frequency response

figure;
subplot(2, 1, 1);
plot(w/pi, abs(Hw)); %magnitude response

subplot(2, 1, 2);
plot(w/pi, angle(Hw)); %phase response
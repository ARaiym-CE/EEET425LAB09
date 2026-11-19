%EEET425 LAB09 q1a

b = [-2 5.65 -2.88]; %numerator coefficients
a = [1 -0.1 0.09 0.648]; %denominator coefficients

%part a residuez forward, H(z) to residues and poles
[r, p, k] = residuez(b, a) %k is empty since order of num < order of den
abs(p) %pole magnitudes, all need to be less than 1 for stability

%part a pull out the complex pair and the real pole
ic = find(abs(imag(p)) > 1e-6); %indices of the complex poles
ir = find(abs(imag(p)) <= 1e-6); %index of the real pole
r1 = r(ic(1)); p1 = p(ic(1)); %one of the complex conjugate pair

%part a combine the conjugate pair into a real second order section
b_sec = [2*real(r1), -2*real(r1*conj(p1))] %numerator of the second order section
a_sec = [1, -2*real(p1), abs(p1)^2] %denominator of the second order section
b_fo = real(r(ir)) %numerator of the first order section
a_fo = [1, -real(p(ir))] %denominator of the first order section

%part a residuez backward, residues and poles back to H(z)
[b_chk, a_chk] = residuez(r, p, k) %should match the original b and a

function [edge] = edgedetector(input_img)

img = double(input_img);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

[Rx,Ry] = gradient(R);
[Gx,Gy] = gradient(G);
[Bx,By] = gradient(B);

Sx = Rx.^2+Gx.^2+Bx.^2;
Sy = Ry.^2+Gy.^2+By.^2;
Sxy = Rx.*Ry+Gx.*Gy+Bx.*By;


D = sqrt(abs((Sx-Sy).^2+4*(Sxy.^2)));% Discriminant of the Characteristic Equation of Image structure matrix
eigVal1 = sqrt((Sx+Sy+D)/2);  

edge  = eigVal1;

end
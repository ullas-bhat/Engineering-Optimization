% Valve spring design  - Exercise 5.1

% Computation of gradients of objective function and constraint g1.


% Initialization
clf, hold off, clear

set(gca,'DefaultTextFontSize',18)

% Note: Constant parameter values are read within the functions sprobj1 and sprcon1

% Design point for which gradients are computed 
x = [0.024 0.004];  

% Forward finite diffence gradients of objective function and constraints
hx = logspace(-20,0,100); % vector of finite difference steps
for i=1:1:length(hx)

  % Finite diffence step
  hxi = hx(i);

  % Objective function
  fx = springobj1(x);
  fx1plush = springobj1([x(1)+hxi, x(2)]);
  fx2plush = springobj1([x(1), x(2)+hxi]);
  dfdx1(i) = (fx1plush - fx)/hxi;
  dfdx2(i) = (fx2plush - fx)/hxi;

  % Constraints 
  gx = springcon1(x);
  gx1plush = springcon1([x(1)+hxi, x(2)]);
  gx2plush = springcon1([x(1), x(2)+hxi]);
  dgdx1(i,:) = (gx1plush - gx)./hxi;
  dgdx2(i,:) = (gx2plush - gx)./hxi;
  % g4 x1 x2
  dg4dx1(i,:) = (gx1plush(4)-gx(4))/hxi;
  dg5dx1(i,:) = (gx1plush(5)-gx(5))/hxi;
  % g5 x1 x2
  dg4dx2(i,:) = (gx2plush(4)-gx(4))/hxi;
  dg5dx2(i,:) = (gx2plush(5)-gx(5))/hxi;
  
  
  for j=1:5
      if dgdx1(i,j)<1 && dgdx1(i,j)>=0
          dgdx1t(i,j)=dgdx1(i,j)+1;
      elseif dgdx1(i,j)>-1 && dgdx1(i,j)<=0
          dgdx1t(i,j)=dgdx1(i,j)-1;
      else
          dgdx1t(i,j)=dgdx1(i,j);
      end
  end
   for j=1:5
      if dgdx2(i,j)<1 && dgdx2(i,j)>=0
          dgdx2t(i,j)=dgdx2(i,j)+1;
      elseif dgdx2(i,j)>-1 && dgdx2(i,j)<=0
          dgdx2t(i,j)=dgdx2(i,j)-1;
      else
          dgdx2t(i,j)=dgdx2(i,j);
      end
   end
  
      if dfdx1(i)<1 && dfdx1(i)>=0
          dfdx1t(i)=dfdx1(i)+1;
      elseif dfdx1(i)>-1 && dfdx1(i)<=0
          dfdx1t(i)=dfdx1(i)-1;
      else
          dfdx1t(i)=dfdx1(i);
      end
  

      if dfdx2(i)<1 && dfdx2(i)>=0
          dfdx2t(i)=dfdx2(i)+1;
      elseif dfdx2(i)>-1 && dfdx2(i)<=0
          dfdx2t(i)=dfdx2(i)-1;
      else
          dfdx2t(i)=dfdx2(i);
      end
  
  ssqx1(i,:)=((dfdx1t(i))^2)+sumsqr(dgdx1t(i,:));
  ssqx2(i,:)=((dfdx2t(i))^2)+sumsqr(dgdx2t(i,:));
  
  
end
%%
% Plotting finite difference gradients
subplot(221)
semilogx(hx,dfdx1)
xlabel('Difference step hx'), ylabel('df/dx1'), title('Spring mass[plot 1]')

subplot(222)
semilogx(hx,dfdx2)
xlabel('Difference step hx'), ylabel('df/dx2'), title('Spring mass[plot 2]')
% 
% subplot(223)
% semilogx(hx,dgdx1(:,1)')
% xlabel('Difference step hx'), ylabel('dg1/dx1'), title('Length constraint[plot 3]') 
% 
% subplot(224)
% semilogx(hx,dgdx2(:,1)')
% xlabel('Difference step hx'), ylabel('dg1/dx2'), title('Length constraint[plot 4]') 
% %% Plot subplot for g4 g5
% subplot(221)
% semilogx(hx,dg4dx1(:,1)')
% xlabel('Difference step hx'), ylabel('dg4/dx1'), title(' Scaled shear stress constraint direction x1') 
% 
% subplot(222)
% semilogx(hx,dg4dx2(:,1)')
% xlabel('Difference step hx'), ylabel('dg4/dx2'), title(' Scaled shear stress constraint direction x2')
% 
% subplot(223)
% semilogx(hx,dg5dx1(:,1)')
% xlabel('Difference step hx'), ylabel('dg5/dx1'), title(' Scaled frequency constraint direction x1') 
% 
% subplot(224)
% semilogx(hx,dg5dx2(:,1)')
% xlabel('Difference step hx'), ylabel('dg5/dx2'), title(' Scaled frequency constraint direction x2')

% %% Plot sum of square of constraints and objective
subplot(223)
semilogx(hx,ssqx1(:,1))
xlabel('Difference step hx'), ylabel('ssqx1'), title('Sum of Squares in x1')


subplot(224)
semilogx(hx,ssqx2(:,1))
xlabel('Difference step hx'), ylabel('ssqx2'), title('Sum of Squares in x2')

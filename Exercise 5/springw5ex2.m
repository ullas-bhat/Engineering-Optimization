% Valve spring design  - Exercise 5.2
% Checking KKT conditions

% Initialization
clc, clear;

% Design point for evaluating KKT condition
x = [0.020522 0.003520];

% Generating grid 

% Step size for computing finite differences
hi = 1E-08;

% Checking feasibility of the point (allowing for numerical errors)
g = springcon1(x);

exitflag = 0;
for i = 1:length(g)
    if g(i) > 1E-04
        exitflag = -1
        break
    end
end

if exitflag == -1
    disp('Point is not feasible')
else
    % Identifying active constraints
    activecons = [];
    for i = 1:length(g)
        if abs(g(i)) < 1E-03
            activecons(end+1) = i;
        end
    end

    % Calculating constraint gradients:
    gx1plush = springcon1([x(1)+hi x(2)]);
    gx2plush = springcon1([x(1) x(2)+hi]);
    dg1 = (gx1plush - g)./hi;
    dg2 = (gx2plush - g)./hi;
    dg = [dg1; dg2];
    
    % Reducing precision of gradients to account for numerical errors
    for i = 1:length(dg(:,1))
        for j = 1:length(dg(1,:))
            dgappr(i,j) = str2double(num2str(dg(i,j)));
        end
    end

    % Identifying independent constraints:
    for i = 1:length(activecons)
        if isnan(activecons(i))
            continue
        end
        for j = 1:length(activecons)
            if i == j
                continue
            else
                if isnan(activecons(j))
                    continue
                elseif  dgappr(:,activecons(i)) == dgappr(:,activecons(j))
                    activecons(j) = NaN;
                end
            end
        end
    end
    activecons = rmmissing(activecons);
    
    % Calculating objective function gradients
    fx = springobj1(x);
    fx1plush = springobj1([x(1)+hi, x(2)]);
    fx2plush = springobj1([x(1), x(2)+hi]);
    dfdx1 = (fx1plush - fx)/hi;
    dfdx2 = (fx2plush - fx)/hi; 
    df = [dfdx1 dfdx2];

    % Constucting active constraint gradient matrix
    dgactive = zeros(length(activecons));
    for i = 1:length(activecons)
        dgactive(:,i) = dg(:,activecons(i));
    end

    % Calculating legrange multipliers
    mu = -1 * inv(dgactive)*transpose(df)

    for i = 1:length(mu)
        if mu(i) < 0
            disp('KKT condition for the multipliers not met')
            exitflag = -1;
            break
        end
    end
end

if exitflag ~= -1
    disp('KKT conditions met')
end






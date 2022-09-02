function x = descale(x_scaled)
    % Function to descale the design variables
    % x_scaled: scaled design variables
    % x: descaled design variables
    
    P_c_ref = 58E+05;   % reference chamber pressure [Pa]
    A_t_ref = 0.1886;   % reference throat area [m^2]
    A_e_ref = 0.7698;   % reference exit area [m^2]
    x_ref = [P_c_ref A_t_ref A_e_ref]';  % reference design variable

    x = x_scaled .* x_ref;
end
function dB = DFP_update(B, dx, DD)
    % Function to update the Hessian approximation using the DFP method
    % B: Hessian approximation
    % dx: change in x
    % DD: change in gradient
    % dB: updated Hessian approximation
    
    dB = (dx*dx')/(dx'*DD) - ...
        ((B*DD)*(B*DD)')/(DD'*B*DD);
end
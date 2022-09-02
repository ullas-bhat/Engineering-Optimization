function dB = BFGS_update(B, dx, DD)
    % Function to update approximate Hessian using BFGS update
    % B: current approximation of Hessian
    % dx: change in x
    % DD: change in gradient
    % dB: updated approximation of Hessian
    
    dB = (1 + DD'*B*DD/(DD'*dx)) * (dx*dx')/(dx'*DD) - ...
        (dx*(DD'*B) + (DD'*B)'*dx') / (dx'*DD);
end
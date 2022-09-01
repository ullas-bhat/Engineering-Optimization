function dB = BFGS_update(B, dx, DD)
    dB = (1 + DD'*B*DD/(DD'*dx)) * (dx*dx')/(dx'*DD) - ...
        (dx*(DD'*B) + (DD'*B)'*dx') / (dx'*DD);
end
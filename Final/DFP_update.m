function dB = DFP_update(B, dx, DD)
    dB = (dx*dx')/(dx'*DD) - ...
        ((B*DD)*(B*DD)')/(DD'*B*DD);
end
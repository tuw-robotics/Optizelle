% Check that we have an inequality constrained state 
function checkInequalityConstrainedStateT(name,value)
    % Set the error message
    err = sprintf( ...
        'The %s argument must have type InequalityConstrained.State.t.', ...
        name);

    % Check the unconstrained values
    try
        checkUnconstrainedStateT(name,value);
    catch
        error(err);
    end
   
    % Check for the appropriate fields 
    if ~(checkFields({ ...
        'z', ...
        'dz', ...
        'h_x', ...
        'mu', ...
        'mu_est', ...
        'mu_typ', ...
        'eps_mu', ...
        'sigma', ...
        'gamma', ...
        'alpha_z', ...
        'h_diag', ...
        'z_diag'}, ...
        value))
        error(err);
    end
end

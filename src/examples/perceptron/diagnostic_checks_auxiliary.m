% Run a bunch of diagnostic tests on our functions

% Grab the Optizelle library
global Optizelle;
setupOptizelle ();

% Allocate memory for an initial guess and equality multiplier 
x = randn(3,1);
y = zeros(3,1);
z = zeros(3,1);

% Create an optimization state
state=Optizelle.Constrained.State.t( ...
    Optizelle.Rm,Optizelle.Rm,Optizelle.Rm,Optizelle.Messaging,x,y,z);

% Modify the state so that we just run our diagnostics and exit
state.dscheme = Optizelle.DiagnosticScheme.DiagnosticsOnly;
state.f_diag = Optizelle.FunctionDiagnostics.SecondOrder;
state.g_diag = Optizelle.FunctionDiagnostics.SecondOrder;
state.h_diag = Optizelle.FunctionDiagnostics.SecondOrder;
state.iter_max = 2;

% Set the sizes
ninput = 3;
nhidden = 20;
nsamples = 5;

% Grab some lenses
[lens idx]=generate_lenses(ninput,nhidden);

% Generate a random interpolant
xx = randn(idx.size,1);

% Generate some scalings
scaling.x.from.min=-10*ones(3,1);
scaling.x.from.max=10*ones(3,1);
scaling.y.from.min=-10;
scaling.y.from.max=10;
scaling = generate_scaling(x,y,scaling);

% Create a bundle of functions
fns=Optizelle.Constrained.Functions.t;
fns.f=generate_interpolant(generate_hyperbolic(),lens,xx,scaling);
fns.g=generate_hyperbolic();
fns.h=generate_logistic(2.0,3.0,4.0);

% Even though this looks like we're solving an optimization problem,
% we're actually just going to run our diagnostics and then exit.
Optizelle.Constrained.Algorithms.getMin( ...
    Optizelle.Rm,Optizelle.Rm,Optizelle.Rm,Optizelle.Messaging,fns,state);

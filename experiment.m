#!/usr/bin/octave -qf

# Check the number of arguments
if (nargin!=3)
    # Print info message and close if != 3
    printf("Usage: ./experiment.m <data> <alphas> <bes>\n");
    exit(1);
end

# Argument reading
arg_list=argv();
# Data to use
data=arg_list{1};
# Possible alpha values
as=str2num(arg_list{2});
# Possible margin values
bs=str2num(arg_list{3});

# Load data
load(data); 

# Useful variables about size and dimensionality
[N, L] = size(data);
D = L-1;

# Unique leabels
ll = unique(data(:, L));

# Set the seed and permute data randomly
rand('seed', 23);
data = data(randperm(N), :);

# Set the training data to 70% and test to 30%
M = round(0.7*N); #M = number training data
te = data(M+1:N, :); # te = testing data

# Print table header
printf("#      a        b   E   k Ete Ete (%%)     Ite (%%)\n");
printf("#-------  ------- --- --- --- -------- ------------\n");

# Evaluate each combination of a (alpha) and b (margin)
for a=as
    for b=bs
        # Train perceptron on training data
        [w,E,k]=perceptron(data(1:M,:),b,a); rl=zeros(M,1);
        
        # Classify test data
        for n=1:(N-M) rl(n)=ll(linmach(w,[1 te(n,1:D)]')); end
        
        # Calculate confusion matrix and # of errors for test data
        [nerr m]=confus(te(:,L),rl);
        
        # Calculate accuracy based on # of errors
        aprox_err = nerr/(N-M);
        
        # Calculate confidence interval for this evaluation
        interval = 1.96 * sqrt(aprox_err *(1-aprox_err)/(N-M));
        
        # Print new row to table
        printf("%8.4f %8.3f %3d %3d %3d %8.2f [%4.2f, %4.2f]\n",a, b,E,k,nerr, aprox_err*100, max([(aprox_err-interval)*100, 0]), min([(aprox_err+interval)*100, 100]));
    end
end

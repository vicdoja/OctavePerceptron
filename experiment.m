#!/usr/bin/octave -qf
if (nargin!=3)
    printf("Usage: ./experiment.m <data> <alphas> <bes>\n");
    exit(1);
end

arg_list=argv();
data=arg_list{1};
as=str2num(arg_list{2});
bs=str2num(arg_list{3});
load(data); #[N,L]=size(data); D=L-1;

[N, L] = size(data);
D = L-1;
ll = unique(data(:, L));
rand('seed', 23);
data = data(randperm(N), :);
M = round(0.7*N); #M = number training data
te = data(M+1:N, :); # te = testing data

printf("#      a        b   E   k Ete Ete (%%)     Ite (%%)\n");
printf("#-------  ------- --- --- --- -------- ------------\n");

for a=as
    for b=bs
        [w,E,k]=perceptron(data(1:M,:),b,a); rl=zeros(M,1);
        for n=1:(N-M) rl(n)=ll(linmach(w,[1 te(n,1:D)]')); end
        [nerr m]=confus(te(:,L),rl);
        aprox_err = nerr/(N-M);
        interval = 1.96 * sqrt(aprox_err *(1-aprox_err)/(N-M));
        
        printf("%8.4f %8.3f %3d %3d %3d %8.2f [%4.2f, %4.2f]\n",a, b,E,k,nerr, aprox_err*100, max([(aprox_err-interval)*100, 0]), min([(aprox_err+interval)*100, 100]));
    end
end

#!/usr/bin/octave -qf
if (nargin!=3)
    printf("Usage: ./experiment.m <data> <alphas> <bes>\n");
    exit(1);
end

arg_list=argv();
data=arg_list{1};
as=str2num(arg_list{2});
bs=str2num(arg_list{3});
load(data); [N,L]=size(data); D=L-1;

[N, L] = size(data);
D = L-1;
ll = unique(data(:, L));
rand('seed', 23);
data = data(randPerm(N));
M = N - round(0.7*N);
te = data(N-M+1:N, :);

for a=as
    for b=bs
        [w,E,k]=perceptron(data(1:NTr,:),b,a); rl=zeros(M,1);

        ...
# This function trains a perceptron
# Parameter "a" controls the learning rate (alpha) for the opt. 
# Parameter "b" controls the margin for the opt.
# Parameter "K" sets the maximum number of iterations (or epochs)
# Parameter "iw" sets the initial weights, zeros if not used
function [w,E,k]=perceptron(data,b,a,K,iw)

	# Useful variables about size and dimensionality
  [N,L]=size(data); D=L-1;
	
	# Unique labels and # of labels
  labs=unique(data(:,L)); C=numel(labs);
	
	# Interpret parameters
  if (nargin<5) w=zeros(D+1,C); else w=iw; end
  if (nargin<4) K=200; end;
  if (nargin<3) a=1.0; end;
  if (nargin<2) b=0.1; end;
	
	# Iterate K times
  for k=1:K
		# Set initial number of errors
    E=0;
		
		# Run algorithm for each data point
    for n=1:N
			# Extract feature vector
      xn=[1 data(n,1:D)]';
			
			# Extract label of sample
      cn=find(labs==data(n,L));
			
			# Set auxiliar variable and calculate values for each class
      er=0; g=w(:,cn)'*xn;
			
			# Update weights for all classes except the correct one
      for c=1:C; if (c!=cn && w(:,c)'*xn+b>g)
				w(:,c)=w(:,c)-a*xn; er=1; end; end
			
			# If there was a classification error, update the sample's class own weights
      if (er)
				w(:,cn)=w(:,cn)+a*xn; E=E+1; end; end
		
		# If there were no errors in this epoch, convergence is reached and algorithm ends prematurely
    if (E==0) break; end; end
endfunction

# This function performs argmax_c( w_c' * x), returning the optimal c
# Parameter "w" is the weights matrix of shape (D, N)
# Parameter "x" is the sample's feature vector (or data point) of shape (D, 1)
function cstar=linmach(w,x)
  # Get the number of classes and set auxiliary variables
  C=columns(w); cstar=1; max=-inf;
  
  # Check every class for optimality
  for c=1:C
  
    # Value of the linear function for w_c
    g=w(:,c)'*x;
    
    # If the value is greater than previous maximum, store it and the class
    if (g>max) max=g; cstar=c; endif; end
    
    # The funcion finally returns the optimal class "cstar"
endfunction

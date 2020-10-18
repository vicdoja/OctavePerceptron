# This function calculates the confusion matrix
# Parameters "truelabs" and "recolabs" are the true labels and the predicted labels, respectively
# Returns the number of errors and the confusion matrix
function [nerr m]=confus(truelabs,recolabs)

  # Reshape the vectors to make them consistent
  truelabs=reshape(truelabs,numel(truelabs),1);
  recolabs=reshape(recolabs,numel(recolabs),1);
  
  # Auxiliary variables for # of samples, # of classes and unique classes
  N=rows(truelabs); 
  labs=unique([truelabs;recolabs]);
  C=numel(labs); 
  
  # Initialize confusion matrix
  m=zeros(C);
  
  # Add every sample's classification into the confusion matrix
  for n=1:N m(find(labs==truelabs(n)),find(labs==recolabs(n)))++; end
  
  # Compute the # of correct classifications in order to calculate the # of errors
  a=0; for c=1:C a+=m(c,c); end; nerr=N-a;
  
  # Finally, the function returns "nerr" (# of errors) and "m" (the confusion matrix)
endfunction

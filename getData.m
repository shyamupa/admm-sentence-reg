function [M,X,docs,L]=getData()

M=load('data/Mhardware');
corpus_size=size(M,1);

M=sparse((1:corpus_size)',M,ones(corpus_size,1));

L=load('data/Lhardware');

D=load('data/Dhardware');
docLines = 1; 
docIter = 1; 


docs = struct('sent_offsets',[]);
    for i = 1:size(D,1)

        if( D(i,1) ~= 0 ) 
            docs(docIter).sent_offsets(docLines, :) = D(i, :); 
            docLines = docLines + 1; 
        else
            docIter = docIter + 1; 
            docLines = 1; 
        end 
    end 

    
vocab_size=size(M,2);

% X is the feat matrix, with feat for each doc stacked row-wise

X = zeros(length(docs),vocab_size);
for d=1:length(docs)
    if ( mod(d, 30) == 1 )
        disp(['Creating X = '  num2str( 100  *  d / length(docs) ) ' % ' ])
    end
    doc_start=docs(d).sent_offsets(1,1);
    doc_end=docs(d).sent_offsets(end,end);
    X(d, :) = sum(M(doc_start:doc_end,:));
end


end   


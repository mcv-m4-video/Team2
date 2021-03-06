function [vmR, vmC]=SearchAlgorithm(reference, currentBlock, point, cfg)

[blockRows, blockCols] = size(currentBlock);
[rows, cols] = size(reference);
% p = cfg.p;
r1 = point.pointR1;
c1 = point.pointC1;

bSize = cfg.p;
minMad = 65537;

vmR = 0;
vmC = 0;

for rr = -bSize:bSize
    for cc = -bSize:bSize
        refBlockR1 = r1 + rr;
        refBlockR2 = refBlockR1 + blockRows -1;
        refBlockC1 = c1 + cc;
        refBlockC2 = refBlockC1 + blockCols -1;
        
        if ( refBlockR1 < 1 || refBlockR2 > rows || refBlockC1 < 1 || refBlockC2 > cols)
            continue;
        end
        
        referenceBlock = reference(refBlockR1: refBlockR2, refBlockC1: refBlockC2);
        mad = immse(referenceBlock, currentBlock);
        
        if mad <=  minMad
           minMad = mad;
           vmR = rr; 
           vmC = cc;
        end
        
        
    end
end
end
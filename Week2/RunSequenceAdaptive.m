function [sequence] = RunSequenceAdaptive(sequence, cfg)

[bestRho, bestAlpha, sequence] = optimization(sequence);

[~, sequence.adaptive.bestResult ] = EvaluateAlpha(sequence, bestAlpha, true, bestRho);

    function [bestRho, bestAlpha, sequence] = optimization(sequence)
        % compute best inital alpha with non adaptative
        [alphaEvaluation] = EvaluateAlpha(sequence, cfg.alpha, false, 0);
        nonRecursiveResults = alphaEvaluation;
        % plotTask1(alphaEvaluation, cfg)

        [F,I] = sort(extractfield(cell2mat(alphaEvaluation), 'F'), 'descend');
        bestAlpha = cfg.alpha(I(1));
        bestF = F(1)
        iterations = 0;
        fDiff = Inf;
        while (iterations < cfg.maxIterations && fDiff > cfg.minfDiff)
            oldBestF = bestF;
            % compute best rho with the best alpha
            rhoEvaluation = EvaluateRho(sequence, bestAlpha, true, cfg.rho);
            [~,I] = sort(extractfield(cell2mat(rhoEvaluation), 'F'), 'descend');
            bestRho = cfg.rho(I(1));

            % compute alpha with best rho
            [alphaEvaluation] = EvaluateAlpha(sequence, cfg.alpha, true, bestRho);
            [F,I] = sort(extractfield(cell2mat(alphaEvaluation), 'F'), 'descend');
            bestAlpha = cfg.alpha(I(1));
            bestF = F(1)

            iterations = iterations+1
            fDiff = abs(oldBestF - bestF)
        end

        sequence.adaptive.bestAlpha   = bestAlpha;
        sequence.adaptive.F           = bestF;
        sequence.adaptive.bestRho     = bestRho;
        sequence.adaptive.alphaEvaluation = alphaEvaluation;
    end
end
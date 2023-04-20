function index = tackle(aggressorPos, positionMatrix)
    
    tackleArray = zeros(1,4);
        for i = 1:4
            tackleArray(i) = norm(aggressorPos-positionMatrix(i,:));
 
        end

        [~ ,index] = min(tackleArray);
        
        
end
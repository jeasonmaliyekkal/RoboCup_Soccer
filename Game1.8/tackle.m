function index = tackle(aggressorPos, positionMatrix)

        for i = 1:4
            tackleArray = norm(aggressorPos-positionMatrix(i,:));
 
        end
        [~ ,index] = min(tackleArray);
        
        
end
function refreshFrame(strikerPlot,ballPlot,newPos, state)

    for i=1:size(newPos,2)

        if(state == "Possess")
        set(strikerPlot, 'XData', newPos(1,i), 'YData', newPos(2,i));

        elseif(state=="Dribble")
        set(strikerPlot, 'XData', newPos(1,i), 'YData', newPos(2,i));
        set(ballPlot, 'XData', newPos(1,i)+0.2, 'YData', newPos(2,i));
        elseif(state=="Shoot")
        set(ballPlot, 'XData', newPos(1,i), 'YData', newPos(2,i));
        end
        drawnow 
        pause(0.2);
    end

end
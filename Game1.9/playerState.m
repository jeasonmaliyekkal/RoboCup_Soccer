classdef playerState < Simulink.IntEnumType
    enumeration 
        WAIT(1)
        GET_POSSESSION(2)
        DRIBBLE(3)
        SHOOT(4)
        PASS(5)
        TACKLE(6)
        TACKLED(7)
        ASSIST(8)
        SAVE(9)
    end
end

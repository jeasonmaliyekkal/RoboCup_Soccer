classdef playerState < Simulink.IntEnumType
    enumeration 
        WAIT(1)
        GET_POSSESSION(2)
        DRIBBLE(3)
        SHOOT(4)
        PASS(5)
        TACKLE(6)
        ASSIST(7)
    end
end

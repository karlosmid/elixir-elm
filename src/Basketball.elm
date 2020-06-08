module Basketball exposing( position, trials)

trials height =
    if height > 180 then "invite candidate"
    else "reject candidate"

position height =
    if height > 205 then "center"
    else if height > 200 then "forward"
    else "guard"

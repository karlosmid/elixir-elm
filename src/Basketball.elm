module Basketball exposing( position, trials, letter)

trials height =
    if height > 180 then "invite candidate"
    else "reject candidate"

position height =
    if height > 205 then "center"
    else if height > 200 then "forward"
    else if height > 180 then "guard"
    else String.fromInt height
letter first second height = first height ++ " as " ++ second height

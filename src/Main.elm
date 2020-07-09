module Main exposing (main)
import Html exposing (text)

greeting : String
greeting = "Hello, Elm!"

planck : Float
planck = 6.62e-34

elmDeveloper : Bool
elmDeveloper = True

helloThere : String -> String
helloThere name =
    "Hello " ++ name
numberOfLegs : String -> (Int -> String)
numberOfLegs spieces amount =
  spieces ++ " has " ++ Debug.toString amount ++ " legs."

main = text (numberOfLegs "Dog" 4)
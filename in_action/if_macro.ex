defmodule If do
  defmacro if(clause, do: expression) do
    quote do
      if(unquote(clause) == :true, do: unquote(expression))
    end
  end
end

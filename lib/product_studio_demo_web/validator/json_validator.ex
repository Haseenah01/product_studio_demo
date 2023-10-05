defmodule ProductStudioDemoWeb.Validator.JsonValidator do
  def schema do
    %{
      "type" => "object",
      "properties" => %{
        "name" => %{
          "type" => "string",
          "minLength" => 2,
          "maxLength" => 255
        },
        "description" => %{
          "type" => "string",
          "minLength" => 10,
          "maxLength" => 1000
        },
        "price" => %{
          "type" => "number",
          "minimum" => 0.00
        },
        "stock" => %{
          "type" => "integer",
          "minimum" => 0
        }
      },
      "required" => ["name", "price", "stock"]
    }
  end
end

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local sn = ls.snippet_node

local current_module_name = function()
  local path = vim.fn.expand("%:.")
  path = path:gsub("lib/", "")
             :gsub(".ex", "")
             :gsub("/controllers", "")
             :gsub("/", ".")
             :gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
             :gsub("_", "")
  return path
end

local controller_snippet_node = function(index)

  local web_module_name = function()
    local path = vim.fn.expand("%:.")
    path = path:gsub("lib/", "")
    _, _, path = path:find("^(.-)/")
    path = path:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
               :gsub("_", "")
    return path
  end

  local main_module_name = function()
    local path = vim.fn.expand("%:.")
    path = path:gsub("lib/", "")
    _, _, path = path:find("^(.-)/")
    path = path:gsub("_web", "")
               :gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
               :gsub("_", "")
    return path
  end


  local template = [[
  defmodule {} do
    use {}, :controller
    alias {}.Core

    {}

  end
  ]]

  return sn(index, fmt(template, {
    f(current_module_name, {}),
    f(web_module_name, {}),
    f(main_module_name, {}),
    i(1)
  }))
end

local controller_function_snippet_node = function(index)
  local template = [[
    def {}(conn, _params) do
      send_resp(conn, :ok, [])
    end
  ]]
  return sn(index, fmt(template, {
    i(1, "index")
  }))
end

local schema_snippet_node = function(index)
  local template = [[
    defmodule {} do
      use Ecto.Schema
      schema "{}" do
        field :{}, :{}
      end
    end
  ]]
  return sn(index, fmt(template, {
    f(current_module_name, {}),
    i(1, "table_name"),
    i(2, "field_name"),
    i(3, "field_type")
  }))
end

local test_module_snippet_node = function(index)
  local template = [[
    defmodule {} do
      use ExUnit.Case

      describe "{}" do
        test "{}" do
          assert true
        end
      end
    end
  ]]
  return sn(index, fmt(template, {
    f(current_module_name, {}),
    i(1, "my_func/1"),
    i(2, "it does something"),
  }))
end

return {
  s("schema", schema_snippet_node(1)),
  s("controller_function", controller_function_snippet_node(1)),
  s("controller", controller_snippet_node(1)),
  s("test_module", test_module_snippet_node(1))
}

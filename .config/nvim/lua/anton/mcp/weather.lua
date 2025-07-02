-- my vim-native MCP server implementation example
  return {
      name = "weather",
      capabilities = {
          tools = {
              {
                  name = "get_weather",
                  description = "Get weather for a city",
                  inputSchema = {
                      type = "object",
                      properties = {
                          city = {
                              type = "string",
                              description = "City name"
                          }
                      }
                  },
                  handler = function(req, res)
                      return res:text("Weather in " .. req.params.city .. ": Sunny"):send()
                  end
              }
          },
          resources = {
              {
                  name = "current",
                  uri = "weather://london",
                  description = "Current London weather",
                  handler = function(req, res)
                      return res:text("London: Sunny, 22°C"):send()
                  end
              }
          }
      }
  }

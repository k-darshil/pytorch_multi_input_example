# Context7 MCP Server Setup - Remote Workspace

## Overview
Context7 is a Model Context Protocol (MCP) server that provides up-to-date, version-specific documentation and code examples for libraries directly within your prompts. It fetches current documentation straight from the source to eliminate outdated or hallucinated API responses.

## Installation Status ✅
- **Node.js Version**: v22.16.0 (✅ Meets requirement of >=18.0.0)
- **Context7 MCP Package**: Installed globally via npm
- **Installation Location**: `/usr/local/lib/node_modules/@upstash/context7-mcp`

## Available Configurations

### 1. Local Server Connection (Recommended)
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

### 2. Remote Server Connection
```json
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp"
    }
  }
}
```

### 3. Alternative Runtime Options

#### Using Bun (if available):
```json
{
  "mcpServers": {
    "context7": {
      "command": "bunx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

#### Using Deno (if available):
```json
{
  "mcpServers": {
    "context7": {
      "command": "deno",
      "args": ["run", "--allow-net", "npm:@upstash/context7-mcp"]
    }
  }
}
```

## Server Transport Options

The context7 MCP server supports different transport methods:

### STDIO (Default)
```bash
npx @upstash/context7-mcp
```

### HTTP Transport
```bash
npx @upstash/context7-mcp --transport http --port 3000
```

### SSE (Server-Sent Events)
```bash
npx @upstash/context7-mcp --transport sse --port 3000
```

## Usage Instructions

Once the MCP server is configured in your client, simply add `use context7` to your prompts:

### Example Prompts:
```
Create a basic Next.js project with app router. use context7
```

```
Write a Python script using requests to fetch data from an API, include error handling. use context7
```

```
How do I set up a Redis client using the 'redis-py' library? use context7
```

## Available Tools

Context7 provides these MCP tools:

1. **`resolve-library-id`**
   - Resolves library names to Context7-compatible IDs
   - Parameter: `libraryName` (required)

2. **`get-library-docs`**
   - Fetches documentation for specified libraries
   - Parameters:
     - `context7CompatibleLibraryID` (required)
     - `topic` (optional): Focus on specific topics
     - `tokens` (optional, default 10000): Max tokens to return

## Integration with MCP Clients

### Cursor IDE
1. Go to `Settings` → `Cursor Settings` → `MCP`
2. Add new global MCP server
3. Use the configuration from `mcp-config.json` in this workspace

### VS Code (with MCP Extension)
Add to your `settings.json`:
```json
"mcp": {
  "servers": {
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

### Claude Desktop
Add to `claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "Context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

## Testing the Installation

### Test Command Line Access:
```bash
npx @upstash/context7-mcp --help
```

### Test HTTP Server:
```bash
# Start server
npx @upstash/context7-mcp --transport http --port 3000

# Test in another terminal
curl http://localhost:3000
```

## Troubleshooting

### Common Issues:

1. **Module Not Found Error**
   - Try using `bunx` instead of `npx`
   - Ensure Node.js version is 18+

2. **Permission Issues**
   - Use `sudo npm install -g` if needed
   - Check npm global permissions

3. **Port Conflicts**
   - Change port: `--port 3001`
   - Check for running processes: `lsof -i :3000`

### Node.js VM Modules Issue:
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "--node-options=--experimental-vm-modules", "@upstash/context7-mcp"]
    }
  }
}
```

### TLS Issues:
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "--node-options=--experimental-fetch", "@upstash/context7-mcp"]
    }
  }
}
```

## Security Considerations

- Context7 makes external API calls to fetch documentation
- Ensure your firewall allows outbound HTTPS connections
- No sensitive data is sent to Context7 servers
- All library documentation fetched is public information

## Files Created in This Setup

- `mcp-config.json`: Basic MCP configuration file
- `context7-mcp-setup.md`: This documentation file

## Benefits of Context7

- ✅ **Up-to-date Documentation**: Version-specific, current information
- ✅ **No Hallucinated APIs**: Real, documented functions only
- ✅ **Seamless Integration**: Works within existing prompts
- ✅ **No Tab Switching**: Documentation delivered directly in context
- ✅ **Multiple Library Support**: Covers popular frameworks and libraries

## Next Steps

1. Copy the appropriate configuration to your MCP client
2. Restart your MCP client to load the server
3. Test with a simple prompt containing "use context7"
4. Monitor logs for any connection issues

## Support and Resources

- **Official Documentation**: https://lobehub.com/mcp/upstash-context7
- **GitHub Repository**: https://github.com/upstash/context7
- **Issue Reporting**: GitHub Issues or official support channels

---

**Installation Date**: $(date)
**Workspace**: /workspace
**Setup Status**: ✅ Complete and Ready for Use
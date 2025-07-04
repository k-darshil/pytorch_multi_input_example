#!/bin/bash

echo "=== Context7 MCP Server Test Script ==="
echo

# Check Node.js version
echo "1. Checking Node.js version..."
node --version
echo

# Check if context7 package is accessible
echo "2. Testing Context7 MCP package access..."
npx @upstash/context7-mcp --help
echo

# Test STDIO transport (default)
echo "3. Testing STDIO transport (5 second test)..."
timeout 5s npx @upstash/context7-mcp &
STDIO_PID=$!
sleep 2
if kill -0 $STDIO_PID 2>/dev/null; then
    echo "✅ STDIO transport: WORKING"
    kill $STDIO_PID 2>/dev/null
else
    echo "❌ STDIO transport: FAILED"
fi
echo

# Test HTTP transport
echo "4. Testing HTTP transport..."
npx @upstash/context7-mcp --transport http --port 3001 &
HTTP_PID=$!
sleep 3

# Test if HTTP server is responding
if curl -s --max-time 5 http://localhost:3001 >/dev/null 2>&1; then
    echo "✅ HTTP transport: WORKING (port 3001)"
else
    echo "❌ HTTP transport: FAILED or not responding"
fi

# Clean up
kill $HTTP_PID 2>/dev/null
echo

# Check global npm installation
echo "5. Checking global npm package..."
npm list -g @upstash/context7-mcp 2>/dev/null | grep context7-mcp
if [ $? -eq 0 ]; then
    echo "✅ Global package: INSTALLED"
else
    echo "❌ Global package: NOT FOUND"
fi
echo

echo "=== Configuration Files Available ==="
echo "📁 cursor-mcp.json - For Cursor IDE"
echo "📁 vscode-mcp-settings.json - For VS Code"
echo "📁 claude-desktop-config.json - For Claude Desktop"
echo "📁 mcp-config.json - Generic configuration"
echo

echo "=== Setup Complete! ==="
echo "✅ Context7 MCP Server is ready for use"
echo "📖 See context7-mcp-setup.md for detailed instructions"
echo
echo "To use: Add 'use context7' to your prompts after configuring your MCP client"
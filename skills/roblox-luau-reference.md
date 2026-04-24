# Skill: Luau Quick Reference

## When to Use
When writing Roblox Luau code and need to recall syntax, patterns, or API conventions.

## Core Patterns

### Service Access
```luau
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local SSS = game:GetService("ServerScriptService")
local UIS = game:GetService("UserInputService")  -- client only
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
```

### RemoteEvent (client-server comms)
```luau
-- Server: listen
remote.OnServerEvent:Connect(function(player: Player, ...) end)
-- Client: fire to server
remote:FireServer(...)
-- Server: fire to one client
remote:FireClient(player, ...)
-- Server: fire to all
remote:FireAllClients(...)
```

### RemoteFunction (request-response)
```luau
-- Server: handle
remote.OnServerInvoke = function(player: Player, ...): any end
-- Client: call
local result = remote:InvokeServer(...)
```

### Connections & Cleanup
```luau
local conn = event:Connect(function() end)
conn:Disconnect()  -- always clean up
```

### Tweening
```luau
local info = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tween = TweenService:Create(instance, info, {Position = target})
tween:Play()
```

### DataStore (server only)
```luau
local DSS = game:GetService("DataStoreService")
local store = DSS:GetDataStore("PlayerData")
local data = store:GetAsync(key)
store:SetAsync(key, value)
store:UpdateAsync(key, function(old) return new end)
```

### Type Annotations
```luau
local function greet(name: string, age: number?): string
    return `Hello {name}`
end

type Config = {
    speed: number,
    name: string,
    options: { string },
}
```

## Common Pitfalls
- `wait()` is deprecated — use `task.wait()`
- `spawn()` is deprecated — use `task.spawn()` or `task.defer()`
- `delay()` is deprecated — use `task.delay()`
- Don't use `Instance.new("Part", parent)` — set Parent last for performance
- String interpolation uses backticks: `` `Hello {name}` `` not `"Hello " .. name`

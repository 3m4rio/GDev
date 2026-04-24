--!strict
-- Client entry point

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

print("[Client] Player loaded:", player.Name)

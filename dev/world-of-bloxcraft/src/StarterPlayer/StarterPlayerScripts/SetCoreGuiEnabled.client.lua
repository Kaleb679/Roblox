local StarterGui = game:GetService("StarterGui")
task.wait(1)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) -- disables all
task.wait(1)
-- OR disable only some:
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
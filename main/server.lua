local allowedSessionsPerLicense = 1
local players = {}

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local playerLicense = GetPlayerIdentifiers(source)[1]
    if not players[playerLicense] then
        players[playerLicense] = 1
    else
        players[playerLicense] = players[playerLicense] + 1
    end
    deferrals.defer()
    Wait(1000)
    deferrals.presentCard([==[
        {
            "type": "AdaptiveCard",
            "body": [
                {
                    "type": "Container",
                    "items": [
                        {
                            "type": "Image",
                            "url": "https://media.discordapp.net/attachments/627114895183446016/1098982788079820920/logo1-eyes.png",
                            "size": "Medium",
                            "horizontalAlignment": "Center",
                            "spacing": "Medium"
                        },
                        {
                            "type": "TextBlock",
                            "text": "EYES - Multi Account Blocker!",
                            "weight": "Bolder",
                            "size": "Large",
                            "horizontalAlignment": "Center",
                            "spacing": "Medium"
                        },
                        {
                            "type": "TextBlock",
                            "text": "Checking your history...",
                            "wrap": true,
                            "horizontalAlignment": "Center",
                            "spacing": "Medium"
                        }
                    ],
                    "verticalContentAlignment": "Center",
                    "horizontalAlignment": "Center"
                }
            ],
            "actions": [
                {
                    "type": "Action.OpenUrl",
                    "title": "Website",
                    "url": "https://eyestore.tebex.io/"
                },
                {
                    "type": "Action.OpenUrl",
                    "title": "Discord",
                    "url": "https://discord.gg/EkwWvFS"
                }
            ],
            "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
            "version": "1.3"
        }
    ]==])
    Wait(2000)  
    if players[playerLicense] > allowedSessionsPerLicense then
        deferrals.done('Kicked')
    else
        deferrals.done()
    end
end)


AddEventHandler('playerDropped', function()
    local playerLicense = GetPlayerIdentifiers(source)[1]
    if players[playerLicense] then
        print(players[playerLicense], 'The player has left the game, the limit has been renewed!')
        players[playerLicense] = players[playerLicense] - 1
        if players[playerLicense] == 0 then
            players[playerLicense] = nil
        end
    end
end)
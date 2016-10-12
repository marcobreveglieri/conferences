object BotServiceModule: TBotServiceModule
  OldCreateOrder = False
  AllowPause = False
  DisplayName = 'ITDevCon Bot Service'
  StartType = stManual
  WaitHint = 120000
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end

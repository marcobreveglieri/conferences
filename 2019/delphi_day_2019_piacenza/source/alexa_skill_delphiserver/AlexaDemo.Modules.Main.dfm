object MainWebModule: TMainWebModule
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = DefaultHandlerAction
    end>
  Height = 230
  Width = 415
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |w|
      w.rootViewController = UINavigationController.alloc.initWithRootViewController(
#        SandboxViewController.new
        HeroesViewController.new.tap do |c|
          c.battletag = BattleTag.new('Espo', '1977')
        end
      )
      w.rootViewController.navigationBar.barStyle = UIBarStyleBlack
      w.makeKeyAndVisible
    end
  end
end

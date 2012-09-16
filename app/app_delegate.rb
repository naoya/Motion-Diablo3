class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |w|
      w.rootViewController = UINavigationController.alloc.initWithRootViewController(
        HeroesViewController.new.tap do |c|
          c.battletag = BattleTag.new('Espo', '1977')
        end
      )
      w.makeKeyAndVisible
    end
  end
end

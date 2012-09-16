# -*- coding: utf-8 -*-
class HeroesViewController < UITableViewController
  attr_accessor :battletag

  def viewDidLoad
    super
    @heroes = nil

    self.navigationItem.title = self.battletag.to_s
    self.view.backgroundColor = UIColor.blackColor
    self.view.separatorColor  = UIColor.darkGrayColor

    Diablo3::Career.fetch(self.battletag) do |career|
      @heroes = career.heroes
      view.reloadData
    end

    ## デバッグ用(でした)
    # Dispatch::Queue.concurrent.async do
    #   career = Diablo3::Career.get('Espo', '1977')
    #   Dispatch::Queue.main.sync do
    #     @heroes = career.heroes
    #     view.reloadData
    #   end
    # end
  end

  def tableView(tableView, numberOfRowsInSection:section)
    if @heroes.nil?
      return 0
    else
      return @heroes.length
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('heroCell') ||
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:'heroCell')
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator
    cell.textLabel.text = @heroes[indexPath.row].name
    cell.textLabel.textColor = UIColor.whiteColor
    cell.detailTextLabel.text = "Level " + @heroes[indexPath.row].level.to_s + " " + @heroes[indexPath.row].classname.capitalize
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    ItemsViewController.new.tap do |c|
      c.hero = @heroes[indexPath.row]
      navigationController.pushViewController(c, animated:true)
    end
  end
end

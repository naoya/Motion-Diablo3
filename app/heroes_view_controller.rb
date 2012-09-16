# -*- coding: utf-8 -*-
class HeroesViewController < UITableViewController
  def viewDidLoad
    super

    @heroes = nil

    self.navigationItem.title = "Espo#1977"
    self.view.backgroundColor = UIColor.whiteColor

    Diablo3::Career.fetch('Espo', '1977') do |career|
      puts "[DEBUG] callback"
      @heroes = career.heroes

      puts "[DEBUG] pushed heroes"
      puts @heroes.first.name

      view.reloadData
      # App.alert("hige")
      puts "[DEBUG] reloaded DATA"

      ## この関数抜けるときに落ちてるのかなあ ... "っぽい"
    end

    # ここまでこない
    puts "test test"
  end

  def tableView(tableView, numberOfRowsInSection:section)
    puts "[DEBUG] return number of rows"
    if @heroes.nil?
      return 0
    else
      puts @heroes.length
      return @heroes.length
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('heroCell') ||
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:'heroCell')
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator
    cell.textLabel.text = @heroes[indexPath.row].name
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

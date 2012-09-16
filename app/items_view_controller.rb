# -*- coding: utf-8 -*-
class ItemsViewController < UITableViewController
  attr_accessor :hero

  @@order = [
    'mainHand',
    'offHand',
    'head',
    'torso',
    'feet',
    'hands',
    'shoulders',
    'legs',
    'bracers',
    'waist',
    'rightFinger',
    'leftFinger',
    'neck'
  ]

  @@string2color = {
    'yellow' => UIColor.yellowColor,
    'blue'   => UIColor.blueColor,
    'white'  => UIColor.whiteColor,
    'orange' => UIColor.orangeColor,
    'green'  => UIColor.greenColor
  }

  def viewDidLoad
    super

    self.navigationItem.title = hero.name
    self.view.backgroundColor = UIColor.blackColor
    self.view.separatorColor  = UIColor.darkGrayColor

    @items = {}
    @images = {}

    hero.fetch_detail do |detail|
      @items = detail.items
      view.reloadData
    end
  end

  def tableView(tableView, numberOfRowsInSection:section)
    if @items.nil?
      return 0
    else
      # return @items.size
      return @@order.size
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('itemCell') ||
      ItemCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:'itemCell')

    part = @@order[indexPath.row]
    cell.detailTextLabel.text = part
    if @items[part]
      cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator
      cell.textLabel.text = @items[part].name
      cell.textLabel.textColor = @@string2color[@items[part].display_color]

      ## 画像読み込み with GCD
      if not @images[part]
        cell.imageView.image = nil

        Dispatch::Queue.concurrent.async do
          @images[part] = UIImage.alloc.initWithData(NSData.dataWithContentsOfURL(NSURL.URLWithString(@items[part].image_url('large'))));
          Dispatch::Queue.main.sync do
            cell.imageView.image = @images[part]
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation:false)
          end
        end
      else
        cell.imageView.image = @images[part]
      end
    else
      cell.accessoryType  = UITableViewCellAccessoryNone
      cell.textLabel.text = nil
    end

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    # TODO
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    return 64 + 2
  end
end

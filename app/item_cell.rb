class ItemCell < UITableViewCell
  def layoutSubviews
    super
    if self.imageView.image
      self.imageView.frame = [[2, 2], [64, 64]]
      self.imageView.contentMode = UIViewContentModeScaleAspectFit
    end

    self.textLabel.frame = [[69, self.textLabel.frame.origin.y], [self.textLabel.frame.size.width, self.textLabel.frame.size.height]]
    self.detailTextLabel.frame = [[69, self.detailTextLabel.frame.origin.y], [self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height]]
  end
end

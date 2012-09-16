BattleTag = Struct.new(:name, :code) do
  def profile_url
    return "http://us.battle.net/api/d3/profile/#{self.name}-#{self.code}/"
  end

  def hero_url(hero_id)
    return "http://us.battle.net/api/d3/profile/#{self.name}-#{self.code}/hero/#{hero_id}"
  end

  def to_s
    return self.name + "#" + self.code
  end
end

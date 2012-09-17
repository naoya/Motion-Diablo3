class SandboxViewController < UIViewController
  def viewDidLoad
    super

    begin
      @tag = BattleTag.new('Espo', '1977')

      Diablo3::Career.fetch(@tag) do |career|
        career.heroes.first.fetch_detail do |hero|
          puts hero.name      # => Espomax
          puts hero.classname # => monk
          puts hero.level     # => 60

          puts hero.items['offHand'].name      # => StormShield
          puts hero.items['offHand'].image_url # => http://us.media.blizzard.com/d3/icons/....png
        end
      end

    rescue => e
      Alert(e)
    end

  end
end

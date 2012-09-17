Diablo 3 Web API wrapper for RubyMotion
=====

http://blizzard.github.com/d3-api-docs/ の API をラッパした RubyMotion 用のクラスです。lib 以下に入っています。基礎部分のみで対応してないAPIやデータなど多数あります (pull request welcome)

    @tag = BattleNet.new('Espo', '1977')
    Diablo3::Career.fetch(@tag) do |career|
      career.heroes.first.fetch_detail do |hero|
        puts hero.name      # => Espomax
        puts hero.classname # => monk
        puts hero.level     # => 60
        
        puts hero.items['offHand'].name      # => StormShield
        puts hero.items['offHand'].image_url # => http://us.media.blizzard.com/d3/icons/....png
      end
    end

サンプル
--------------------
![01](http://dl.dropbox.com/u/2586384/image/20120917_124210.png)

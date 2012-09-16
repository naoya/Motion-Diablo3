module Diablo3
  class Item
    attr_reader :name, :icon, :display_color, :tooltip_params, :required_level, :item_level, :bonus_affixes
    def self.fetch(hash, &block)
      BW::HTTP.get("http://us.battle.net/api/d3/data/item/#{hash}") do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
          block.call(self.new(json))
        else
          raise response.status_code
        end
      end
    end

    def image_url(size = 'small')
      return "http://us.media.blizzard.com/d3/icons/items/#{size}/#{self.icon}.png"
    end

    def initialize(json)
      @name           = json['name']
      @icon           = json['icon']
      @display_color  = json['displayColor']
      @tooltip_params = json['tooltipParams']
      @required_level = json['requiredLevel']
      @item_level     = json['itemLevel']
      @bonux_affixes  = json['bonusAffixes']
    end
  end
end

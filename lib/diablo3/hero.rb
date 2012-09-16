module Diablo3
  class Hero
    attr_reader :id, :name, :gender, :level, :hardcore, :skills, :items

    def self.fetch(tag, hero_id, &block)
      BW::HTTP.get(tag.hero_url(hero_id)) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
          block.call(self.new(json))
        else
          raise response.status_code
        end
      end
      self
    end

    def initialize(json)
      @id       = json['id']
      @name     = json['name']
      @gender   = json['gender']
      @level    = json['level']
      @hardcore = json['hardcore']
      @skills   = json['skills']

      @items = {}
      json['items'].each {|k,v| @items[k] = Item.new(v) }
    end

    class Item
      attr_reader :name, :icon, :display_color, :tooltip_params

      def initialize(json)
        @name           = json['name']
        @icon           = json['icon']
        @display_color  = json['displayColor']
        @tooltip_params = json['tooltipParams']
      end

      ## FIXME: not DRY
      def image_url(size = 'small')
        return "http://us.media.blizzard.com/d3/icons/items/#{size}/#{self.icon}.png"
      end

      def hash
        self.tooltip_params.split("/").last
      end

      def fetch_detail(&block)
        Diablo3::Item.fetch(self.hash) do |item|
          block.call(item)
        end
      end
    end
  end
end

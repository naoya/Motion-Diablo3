# -*- coding: utf-8 -*-
module Diablo3
  class Career
    attr_reader :battletag, :heroes

    def self.fetch(name, code, &block)
      # この辺の変数の生存時間が怪しいのかも...
      tag  = BattleTag.new(name, code)
      json = nil

      BW::HTTP.get(tag.profile_url) do |response|
        puts "[DEBUG] status code: " + response.status_code.to_s

        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
          puts "[DEBUG] finished parsing json"
          career = self.new(tag, json)
          puts "[DEBUG] finished creating a career object"

          block.call(career)
        else
          raise response.status_code
        end
      end
      self
    end

    def initialize(tag, json)
      puts "[DEBUG] initializing..."

      ## ここで時々落ちる... 変数(tag)の生存区間の問題か?
      @battletag = tag

      puts "[DEBUG] starting map..."
      @heroes    = json['heroes'].map {|h| Hero.new(h) }
      puts "[DEBUG] done map..."
    end

    class Hero
      attr_reader :name, :id, :level, :hardcore, :gender, :dead, :classname

      def initialize(json)
        @name       = json['name']
        @id         = json['id']
        @level      = json['level']
        @hardcore   = json['hardcore']
        @gender     = json['gender']
        @dead       = json['dead']
        @classname  = json['class']
      end

      def fetch_detail(&block)
        Diablo3::Hero.fetch('Espo', '1977', self.id) do |hero|
          block.call(hero)
        end
      end
    end
  end
end

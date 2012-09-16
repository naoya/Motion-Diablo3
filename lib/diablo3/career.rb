# -*- coding: utf-8 -*-
module Diablo3
  class Career
    attr_reader :battletag, :heroes

    def self.fetch(tag, &block)
      json = nil

      BW::HTTP.get(tag.profile_url) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
          career = self.new(tag, json)
          block.call(career)
        else
          raise response.status_code
        end
      end
      self
    end

    ## 同期型 (デバッグ用)
    def self.get(tag)
      json = nil

      error_ptr = Pointer.new(:object)
      data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(tag.profile_url), options:NSDataReadingUncached, error:error_ptr)
      unless data
        raise error_ptr[0]
      end

      json = NSJSONSerialization.JSONObjectWithData(data, options:0, error:error_ptr)
      unless json
        raise error_ptr[0]
      end
      return self.new(tag, json)
    end

    def initialize(tag, json)
      @battletag = tag
      @heroes    = json['heroes'].map {|h| Hero.new(tag, h) }
    end

    class Hero
      attr_reader :battletag, :name, :id, :level, :hardcore, :gender, :dead, :classname

      def initialize(tag, json)
        @battletag  = tag
        @name       = json['name']
        @id         = json['id']
        @level      = json['level']
        @hardcore   = json['hardcore']
        @gender     = json['gender']
        @dead       = json['dead']
        @classname  = json['class']
      end

      def fetch_detail(&block)
        Diablo3::Hero.fetch(self.battletag, self.id) do |hero|
          block.call(hero)
        end
      end
    end
  end
end

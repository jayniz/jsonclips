module Movieclips
  module Search
    def self.search(params)
      raw = HTTP.request('search/videos', params)
      entries = raw[:body]['feed']['entry']
      return empty unless entries

      # When movieclips finds exactly one hit, the search
      # returns not an array, but only that hit. So yeah.
      entries = [entries].flatten
      s = entries.map{|e| parse_entry(e)}.compact
      [raw[:status], {}, s.to_json]
    end

    def self.parse_entry(e)
      {
        type: 'video',
        id:    e['mc:id'],
        title: e['title'],
        url:   e['id'],
        duration: e['media:group']['media:content']['@duration'],
        image_url: extract_images(e).last,
        thumbnail_url: extract_images(e).first,
        player_url: e['media:group']['media:player']['@url']
      }
    end

    private

    def self.extract_images(e)
      sizes = e['media:group']['media:thumbnail'].sort_by do |t|
        t['@height'].to_i
      end.map{|p| p['@url']}
    end

    def self.empty
      [200, {}, '[]']
    end
  end
end

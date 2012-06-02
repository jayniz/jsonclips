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
      {id: e['id'],
       title: e['title']
      }
    end

    private

    def self.empty
      [200, {}, '[]']
    end
  end
end

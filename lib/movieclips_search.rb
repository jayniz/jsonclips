module Movieclips
  module Search
    def self.search(params, options = {})

      # Make the request
      raw = HTTP.request('search/videos', params)
      entries = raw[:body]['feed']['entry']
      return empty unless entries

      # When movieclips finds exactly one hit, the search
      # returns not an array, but only that hit. So yeah.
      entries = [entries].flatten
      s = entries.map{|e| parse_entry(e)}.compact

      # Exclude movie names if asked for
      if options[:exclude_movie]
        s = s.select do |e|
          title = e[:movie][:name]
          select = true
          options[:exclude_movie].split(",").each do |f|
            next unless title.downcase.include?(f)
            select = false
          end
          select
        end
      end

      [raw[:status], {}, s.to_json]
    end

    def self.parse_entry(e)
      movie  = extract_movie(e)
      images = extract_images(e)
      {
        type:          'video',
        id:            e['mc:id'],
        title:         e['title'],
        url:           e['id'],
        duration:      e['media:group']['media:content']['@duration'],
        image_url:     images.last,
        thumbnail_url: images.first,
        player_url:    e['media:group']['media:player']['@url'],
        movie:         movie
      }
    end

    private

    def self.extract_images(e)
      sizes = e['media:group']['media:thumbnail'].sort_by do |t|
        t['@height'].to_i
      end.map{|p| p['@url']}
    end

    def self.extract_movie(e)
      result = {}
      s = e['media:group']['media:description'].split('</a')[0]
      result[:id] = s.match(/movieclips.com\/([^-]+)-/)[1] rescue :error
      result[:name] = s.split('>')[1] rescue :error
      result
    end

    def self.empty
      [200, {}, '[]']
    end
  end
end

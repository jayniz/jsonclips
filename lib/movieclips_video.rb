module Movieclips
  module Video
    def self.show(id)
      raw = HTTP.request("videos/#{id}")
      [raw[:status], {}, raw[:body]]
    end
  end
end

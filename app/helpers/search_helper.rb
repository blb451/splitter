module SearchHelper

  def render_search_results(results)
    results.map do |k, v|
      send("#{k.to_s}_results", v)
    end.join('')
  end

  def artists_results(artists)
    artists.each do |artist|
     artist.name  link_to "Show", search_path(artist.id, {artist_true: true}), remote: true
    end
  end

end

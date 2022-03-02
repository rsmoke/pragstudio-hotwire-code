module FishCatchesHelper

  def total_weight(fish_catches)
    fish_catches.map(&:weight).reduce(0, &:+)
  end

  def sort_link_to(name, column)
    text = "#{name} #{direction_indicator(column)}".html_safe

    params =
      request.params.merge(sort: column, direction: next_direction(column))

    link_to text, params, class: "text-gray-400"
  end

  def next_direction(column)
    if params[:sort] == column.to_s
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end

  def direction_indicator(column)
    if params[:sort] == column.to_s
      tag.span(class: "sort sort-#{next_direction(column)}")
    end
  end

  def render_update_stats_stream(fish_catches)
    turbo_stream.update "stats" do
      render "tackle_box_items/stats", fish_catches: fish_catches
    end
  end

end

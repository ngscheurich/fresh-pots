class BrewStats
  def initialize(count = 40)
    @brews = Brew.first(count)
  end

  def by_time
    return {} if @brews == []

    data =
      @brews.map do |brew|
        time = nearest_half_hour(brew.created_at.localtime)
        time.strftime("%H:%M")
      end

    data = aggregate(data).sort_by { |time, _| time }
    data = add_empty_times(data)
    format_time_data(data.sort_by { |t, _| t })
  end

  def by_variety
    aggregate(@brews.map { |brew| brew.variety.name })
  end

  def by_pot
    aggregate(@brews.map { |brew| brew.pot.name })
  end

  def by_user
    aggregate(@brews.map(&:user))
  end

  def this_week
    Brew.where("created_at >= '#{Time.zone.today.beginning_of_week}'").count
  end

  def this_month
    Brew.where("created_at >= '#{Time.zone.today.beginning_of_month}'").count
  end

  private

  def nearest_half_hour(time)
    Time.zone.at((time.to_f / 30.minutes).round * 30.minutes)
  end

  def aggregate(data)
    counts = Hash.new(0)
    data.each { |x| counts[x] += 1 }
    counts
  end

  def time_range(data)
    min = Time.zone.parse(data.first[0]).to_i
    max = Time.zone.parse(data.last[0]).to_i

    min..max
  end

  def add_empty_times(data)
    hash = data.to_h

    time_range(data).step(30.minutes).map do |time|
      time = Time.zone.at(time).strftime("%H:%M")
      hash[time] = 0 unless hash[time]
    end

    hash
  end

  def format_time_data(data)
    data.map do |time, qty|
      time = Time.zone.parse(time).strftime("%l:%M %p").lstrip
      [time, qty]
    end
  end
end

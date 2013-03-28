module PostTime

  extend ActiveSupport::Concern

  def post_date
    Time.zone.at(self.post_time).strftime('%F')
  end

  def post_time_string
    Time.zone.at(self.post_time).strftime('%F %T')
  end

  def post_time_string=(value)
    write_attribute :post_time, Date.strptime(value).to_time.to_i
  end
end
module PostSearch

  extend ActiveSupport::Concern

  included do
    scope :scope_ordered_ids, (lambda do |ids|
      if ids
        adapter = ActiveRecord::Base.configurations[Rails.env]['adapter']
        if adapter == 'mysql2'
          where(id: ids)
            .order("FIELD (id, #{ids.join ', '})")
        elsif adapter == 'postgresql'
          condition = ids.map { |v| "id != #{v}" }.join(', ')
          where(id: ids)
            .order(condition)
        end
      else
        none
      end
    end)
  end

  module ClassMethods
    def search(text, order_by_date: false)
      # use_sphinx = false
      # if use_sphinx
      #  result = search_by_sphinx(text, order_by_date)
      # else
      #  result = search_by_mysql(text, order_by_date)
      # end
      result = search_by_mysql(text, order_by_date)
      result
    end

    def search_by_mysql(text, order_by_date)
      query_search = "%#{text}%"
      where('content LIKE ? OR title LIKE ?', query_search, query_search)
        .published
        .ordered
        .pluck(:id)
    end
  end
end
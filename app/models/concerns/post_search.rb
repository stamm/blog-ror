module PostSearch

  extend ActiveSupport::Concern

  module ClassMethods
    def search(text, order_by_date: false)
      use_sphinx = false
      if use_sphinx
        result = search_by_sphinx(text, order_by_date)
      else
        result = search_by_mysql(text, order_by_date)
      end
      result
    end

    def search_by_mysql(text, order_by_date)
      query_search = "%#{text}%"
      where("content LIKE ? OR title LIKE ?", query_search, query_search)
      .order(post_time: :desc)
      .pluck(:id)
    end
  end
end
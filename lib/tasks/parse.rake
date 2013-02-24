desc "Parse from old blog"
task parse: :environment do
  configs = ActiveRecord::Base.configurations

  class Old < ActiveRecord::Base
  end
  Old.establish_connection(configs["old"])


  Post.delete_all

  Old.connection.select_all('select * from tbl_post').each do |e|
    content = e["content"].gsub(/<code>(.*?)<\/code>/im,'```\1```')
    content = content.gsub(/<code lang="([^"]+)">[\r\n]*(.*?)[\r\n]*<\/code>/im,'``` \1
\2
```')

    Post.create(
        title:   e["title"],
        content: content,
        status:  e["status"],
        post_time:  e["post_time"],
        user_id:  e["author_id"],
        url:  e["url"],
        short_url:  e["short_url"],
    )
  end


  #class MysqlConnection < ActiveRecord::Base
  #  self.establish_connection(:adapter => 'mysql', :database => 'some-database-name') # Set all the other required params like host, user-name, etc
  #end
end
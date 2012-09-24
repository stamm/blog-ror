desc "Parse from old blog"
task parse: :environment do
  configs = ActiveRecord::Base.configurations

  class Old < ActiveRecord::Base

  end
  Old.establish_connection(configs["old"])

  Old.connection.select_all('select * from tbl_post').each do |e|
    Post.create(
        title:   e["title"],
        content: e["content"],
        status:  e["status"],
        post_time:  e["post_time"],
        author_id:  e["author_id"],
        url:  e["url"],
        short_url:  e["short_url"],
    )
  end


  #class MysqlConnection < ActiveRecord::Base
  #  self.establish_connection(:adapter => 'mysql', :database => 'some-database-name') # Set all the other required params like host, user-name, etc
  #end
end
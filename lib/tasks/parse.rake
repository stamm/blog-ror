desc "Parse from old blog"
task parse: :environment do
  configs = ActiveRecord::Base.configurations

  class Old < ActiveRecord::Base
  end
  Old.establish_connection(configs["old"])


  ActiveRecord::Base.connection.execute("TRUNCATE #{Post.table_name}")
  ActiveRecord::Base.connection.execute("TRUNCATE #{Comment.table_name}")

  Old.connection.select_all('select * from tbl_post').each do |e|
    content = e["content"].gsub(/<code>(.*?)<\/code>/im,'```\1```')
    content.gsub!(/<code lang="([^"]+)">[\r\n]*(.*?)[\r\n]*<\/code>/im,'``` \1
\2
```')
    content.gsub!('~~~', '```')


    sql = "SELECT t.name FROM tbl_tag AS t, tbl_post_tag AS pt WHERE pt.post_id = #{e['id']} AND t.id = pt.tag_id"
    tag_list = Old.connection.select_all(sql)
      .map { |row| row['name'] }
      .join(',')

    post = Post.create(
        title:   e["title"],
        content: content,
        status:  e["status"],
        post_time:  e["post_time"],
        user_id:  e["author_id"],
        url:  e["url"],
        short_url:  e["short_url"],
        tag_list: tag_list,
    )

    sql = "SELECT * FROM tbl_comment WHERE post_id = #{e['id']} ORDER BY create_time ASC"
    comments = Old.connection.select_all(sql)

    comments.each do |row|
      comment = post.comments.create(
        content: row['content'],
        status: row['status'],
        status: row['status'],
        author: row['author'],
        email: row['email'],
        url: row['url'].nil? ? '' : row['url'],
        ip: row['ip'],
        created_at: Time.at(row['create_time']),
        updated_at: Time.at(row['create_time']),
      )
      #puts row['create_time']

      #comment.update_at = Time.at row['create_time']
      #comment.save
    end
  end

  Tag.recount_frequency

  #class MysqlConnection < ActiveRecord::Base
  #  self.establish_connection(:adapter => 'mysql', :database => 'some-database-name') # Set all the other required params like host, user-name, etc
  #end
end
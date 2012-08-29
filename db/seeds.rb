# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Post.create({title: 'test',
             content: 'content',
             content_display: 'content',
             status: Post::STATUS_TYPES.index(:publish) + 1,
             post_time: Time.now.to_i,
             url: 'test',
            })



Tag.create({name: 'test'})
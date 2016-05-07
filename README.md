Railscasts Episode #181: Include vs Joins

http://railscasts.com/episodes/181

script/console

  c = Comment.all(:joins => :user, :conditions => { :users => { :admin => true } })
  c.first.users
  c = Comment.all(:include => :user, :conditions => { :users => { :admin => true } })
  c.first.users
  User.all(:joins => :comments, :select => "users.*, count(comments.id) as comments_count", :group => "users.id")
  g = Group.first
  Comment.all(:joins => {:user => :memberships}, :conditions => { :memberships => { :group_id => g.id } })


User.all(:joins => :comments, :select => "users.*, count(comments.id) as comments_count", :group => "users.id")




.group('users.id')

User.select('users.*, count(comments.id) as comments_count').joins(:comments)

User.select("users.*, count(comments.id) as comments_count").joins(:comments)

User.joins(:comments).select("users.*, count(comments.id) as comments_count")

Post.select("posts.id, posts.category_id, count(comments.id)").join(:comments).group('posts.category_id').having('count(comments.id) > 0')


Comment.select("comment.id, comments.user_id, count(comments.id)").join(:users).having('count(comments.id) > 0')


User.select("users.id, COUNT(comments.id) AS comment_count").joins(:comments).group('users.id').having('count(comments.id) > 0')

User.joins(:comments).select('users.*, COUNT(*) AS widget_count').group('users.id')



User.select("users.id, count(comments.id) AS comment_count").joins(:comments).group("users.id").all
  User Load (0.2ms)  SELECT users.id, COUNT(comments.id) AS comment_count FROM "users" INNER JOIN "comments" ON "comments"."user_id" = "users"."id" GROUP BY users.id
 => #<ActiveRecord::Relation [#<User id: 1>, #<User id: 2>, #<User id: 4>]>
	 
	 
> User.select("users.id, COUNT(comments.id) AS comment_count").joins(:comments).group('users.id').having('count(comments.id) > 0')
  User Load (0.2ms)  SELECT users.id, COUNT(comments.id) AS comment_count FROM "users" INNER JOIN "comments" ON "comments"."user_id" = "users"."id" GROUP BY users.id HAVING (count(comments.id) > 0)
 => #<ActiveRecord::Relation [#<User id: 1>, #<User id: 2>, #<User id: 4>]>
> exit
injo bparanj$ rails dbconsole
SQLite version 3.8.5 2014-08-15 22:37:57
Enter ".help" for usage hints.
sqlite> SELECT users.id, COUNT(comments.id) AS comment_count FROM "users" INNER JOIN "comments" ON "comments"."user_id" = "users"."id" GROUP BY users.id HAVING (count(comments.id) > 0)
   ...> ;
1|1
2|1
4|1
sqlite> SELECT users.id, COUNT(comments.id) AS comment_count FROM "users" INNER JOIN "comments" ON "comments"."user_id" = "users"."id" GROUP BY users.id HAVING (count(comments.id) > 0);
1|2
2|1
4|1

def post_article(client, user, title, link)
  # is the 'article:' string we're incrementing actually
  # doing anything material other than being an indicator?
  # E.g. we could equally do incr('') but do we need something
  # to also happen on the Redis side? I guess it is keeping track
  # of the integers according to 'article:'
  article_id = client.incr('article:')

  voted = "voted:#{article_id}"
  client.sadd(voted, user)
  client.expire(voted, ONE_WEEK_IN_SECONDS)

  now = Time.now.to_i
  article = "article:#{article_id}"

  client.mapped_hmset(
    article,
    {
      title:  title,
      link:   link,
      poster: user,
      time:   now,
      votes:  1,
    }
  )

  client.zadd('score:', now + VOTE_SCORE, article)
  client.zadd('time:', now, article)

  article_id
end

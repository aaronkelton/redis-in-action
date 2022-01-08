ONE_WEEK_IN_SECONDS = 7 * 86400
VOTE_SCORE          = 432

# @client [redis instance], e.g. Redis.new
# @user [string], e.g. 'user:832795'
# @article [string], e.g. 'article:31649'
def article_vote(client, user, article)
  cutoff = Time.now.to_i - ONE_WEEK_IN_SECONDS
  return if client.zscore('time:', article) < cutoff

  article_id = article.split(':').last

  if client.sadd("voted:#{article_id}", user)
    client.zincrby('score:', VOTE_SCORE, article)
    client.hincrby(article, 'votes', 1)
  end
end

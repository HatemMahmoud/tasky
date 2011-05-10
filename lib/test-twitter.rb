require 'oauth'
c = OAuth::Consumer.new "lfQh3lVjvAjulUrjaFgWEw", "0p6KwrsZDWVNdRjWEqRGT1GIM8chQk80Mc7HRqwtaw", {:site => "api.twitter.com", :authorize_path => "/oauth/authenticate"}

t = OAuth::AccessToken.new c, "10705042-y2YpUzzNItVipxuxzEtKOn6UjcAxrb7XiFvqQADMP", "Jjnjdfc9tAp1dDH9l8X4xEYcHKi8sV3bnVWgy1o"

t.get('/1/account/verify_credentials.json')

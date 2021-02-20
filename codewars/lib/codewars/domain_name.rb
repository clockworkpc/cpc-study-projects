module Codewars
  class DomainName
    def domain_name(url)
      regex = %r[(www\.|[http]\w*\:\/\/)*([a-zA-Z0-9_-]+)]
      url.scan(regex)[0][1]
    end
  end
end

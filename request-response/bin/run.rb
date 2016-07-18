require_relative '../lib/all'

def parse_params(uri_fragments, query_param_string)
  params = {}
  params[:resource]  = uri_fragments[3]
  params[:id]        = uri_fragments[4]
  params[:action]    = uri_fragments[5]
  if query_param_string
    param_pairs = query_param_string.split('&')
    param_k_v   = param_pairs.map { |param_pair| param_pair.split('=') }
    param_k_v.each do |k, v|
      params.store(k.to_sym, v)
    end
  end
  params
end

# You shouldn't need to touch anything in these methods.
def parse(raw_request)
  pieces = raw_request.split(' ')
  method = pieces[0]
  uri    = pieces[1]
  http_v = pieces[2]
  route, query_param_string = uri.split('?')
  uri_fragments = route.split('/')
  protocol = uri_fragments[0][0..-2]
  full_url = uri_fragments[2]
  subdomain, domain_name, tld = full_url.split('.')
  params = parse_params(uri_fragments, query_param_string)
  return {
    method: method,
    uri: uri,
    http_version: http_v,
    protocol: protocol,
    subdomain: subdomain,
    domain_name: domain_name,
    tld: tld,
    full_url: full_url,
    params: params
  }
end

system('clear')
loop do
  print "Supply a valid HTTP Request URL (h for help, q to quit) > "
  raw_request = gets.chomp

  case raw_request
  when 'q' then puts "Goodbye!"; exit
  when 'h'
    puts "A valid HTTP Request looks like:"
    puts "\t'GET http://localhost:3000/users HTTP/1.1'"
    puts "Read more at : http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html"
  else
    @request = parse(raw_request)
    @params  = @request[:params]
    # Use the @request and @params ivars to full the request and
    # return an appropriate response


    if @params[:id]
      if users.count < @params[:id].to_i
        puts "Not a valid input"
      else
        puts users[@params[:id].to_i - 1]
      end

    elsif @params.has_value?("users")
      puts users
    end
  end
end
    # YOUR CODE GOES BELOW HERE
    puts @request.inspect
    class User
      attr_reader :first_name, :last_name, :age
      def initialize(first_name, last_name, age)
        @first_name = first_name
        @last_name = last_name
        @age = age
      end
    end

OK = "200 OK"
NOT_FOUND = "404 NOT FOUND"

def response_ok
  puts OK
end


if url.nil? || url.length.zero?
  raise "No input given"
else
users = [{first_name: "Ahkeem", last_name: "Lang", age: "23"},
  {first_name: "Matt", last_name: "Saz", age: "22"},
  {first_name: "Lexis", last_name: "Corona", age: "24"},
  {first_name: "Paul", last_name: "Varsco", age: "38"},
  {first_name: "Melissa", last_name: "Soul", age: "55"}]
  begin
    response = parser.parse(url)
    if response[:resource] == "random"
      response_body = users.sample

      response_ok
      puts response_body

    elsif response[:resource] == "users"
      if response[:id]

        if response[:action] == "upcase"
          response_body = get_user(users, response[:id]).upcase
        elsif response[:action].nil?
          response_body = get_user(users, response[:id])
        end

        response_ok
        puts response_body
      else
        response_ok
        users.each.with_index do |user, index|
          puts "#{index + 1} - #{user}"
        end
      end
    else
      puts NOT_FOUND
    end
  end
end

      # I can't recall what I was trying to here. I wish I used the README which
      #was required of me to use.
      # if "users" == users
      #   users.each.with_index do |user, index|
      #     print  :params=>{:resource=>users, :id=>nil, :action=>nil}
      #   end
      # elsif
      #   print  :params=>{:resource=>users, :id=>nil, :action=>nil}
      # else
      #   NOT_FOUND
      # end
    # YOUR CODE GOES ABOVE HERE  ^

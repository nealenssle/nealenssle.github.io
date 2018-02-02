require 'optparse'
require 'uri'
require "open-uri"
require 'net/http'

# curl "https://beta.todoist.com/API/v8/tasks?token=TOKEN&filter=due%20today|overdue"

# token = ""
# uri = URI("https://beta.todoist.com/API/v8/tasks?token=#{token}&filter=due%20today|overdue")


# uri = URI.parse('https://beta.todoist.com/API/v8/tasks')
# params = { :token => "", :filter => "due today|overdue" }
# uri.query = URI.encode_www_form(params)

# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# @data = http.get(uri.request_uri)

# res = Net::HTTP.get_response(uri)
# puts res.body if res.is_a?(Net::HTTPSuccess)

params = { :token => "1ee8f7f3510ea1a8e8579c2d0a3b37bfd4e20246", :filter => "due%20today|overdue" }

uri = URI.parse("https://beta.todoist.com/API/v8/tasks")
uri.query = URI.encode_www_form(params)
puts uri.query

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

data = http.get(uri.request_uri)

# data = URI.parse("https://beta.todoist.com/API/v8/tasks?" + params).read

puts data
require 'httparty'
require 'pry'
require 'json'
repo_name = HTTParty.get("https://api.github.com/repos/SethPerna/little-esty-shop")
repo = JSON.parse(repo_name.body, symbolize_names: true)

contributor_name = HTTParty.get("https://api.github.com/repos/SethPerna/little-esty-shop/contributors")
contributors = JSON.parse(contributor_name.body, symbolize_names: true).map { |user| user[:login]}

user_commit = HTTParty.get("https://api.github.com/repos/SethPerna/little-esty-shop/commits")
commits = JSON.parse(user_commit.body, symbolize_names: true)

pull_requests = HTTParty.get()
require "pry"; binding.pry

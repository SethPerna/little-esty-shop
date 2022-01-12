require 'httparty'
require 'pry'
require 'json'
repo_name = HTTParty.get("https://api.github.com/repos/SethPerna/little-esty-shop")
repo = JSON.parse(repo_name.body, symbolize_names: true)

contributor_name = HTTParty.get("https://api.github.com/repos/SethPerna/little-esty-shop/contributors")
contributors = JSON.parse(contributor_name.body, symbolize_names: true).map { |user| user[:login]}

user_commit = HTTParty.get("https://api.github.com/repos/SethPerna/little-esty-shop/commits?page=1&per_page=100")
commits = JSON.parse(user_commit.body, symbolize_names: true)

pull_requests = HTTParty.get("https://api.github.com/repos/SethPerna/little-esty-shop/pulls?state=closed&page=1&per_page=100")
pulls = JSON.parse(pull_requests.body, symbolize_names: true)

commit_count = Hash.new(0)
wip = contributors.each do |user|
  commits.each do |commit|
    if user == commit[:author][:login]
      commit_count[user] += 1
    end
  end
  commit_count
end

class GitHubService
  attr_reader :repo, :contributors
  
end
require "pry"; binding.pry

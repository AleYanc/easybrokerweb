# frozen_string_literal: true

LIMIT = 15
STATUS = 'published'
HEADERS = {
  'Content-Type' => 'application/json',
  'charset' => 'utf-8',
  'X-Authorization' => ENV['API_KEY']
}.freeze
QUERY = {
  'limit' => LIMIT,
  'page' => '1',
  'search[statuses][]' => STATUS
}.freeze

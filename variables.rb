BASE_URL='https://api.stagingeb.com/v1/'
HEADERS = {
  "Content-Type" => 'application/json',
  'charset' => 'utf-8', 
  "X-Authorization"  => ENV['API_KEY']
}
QUERY = {
  "limit" => "15",
  "page" => '1'
}
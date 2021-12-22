HEADERS = {
  "Content-Type" => 'application/json',
  'charset' => 'utf-8', 
  "X-Authorization"  => ENV['API_KEY']
}
QUERY = {
  "limit" => "15",
  "page" => '1'
}
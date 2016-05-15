json.array!(@studysessions) do |studysession|
  json.extract! studysession, :id, :subject, :location, :description
  json.url studysession_url(studysession, format: :json)
end

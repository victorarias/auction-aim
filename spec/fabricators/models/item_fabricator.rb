Fabricator(:item) do
  reserve_met   false
  title         { sequence(:item) {|n| "Item #{n}" }}
  ends_at       1.day.from_now
  published_at  1.day.ago
  watched       false
end

Fabricator(:watched_item, from: :item) do
  watched       true
end

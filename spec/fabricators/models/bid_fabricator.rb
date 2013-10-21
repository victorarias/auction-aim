Fabricator :bid do
  item
  color "#000000"
  amount 100
  reserve_met false
  timestamp Time.now
  external_id { sequence(:external_id) }
end

namespace :app do
  task import: :environment do
    Item.import
  end
end

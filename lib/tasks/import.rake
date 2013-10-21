namespace :app do
  task import: :environment do
    ItemImporter.new.run
  end
end

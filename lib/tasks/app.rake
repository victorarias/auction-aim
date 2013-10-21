namespace :app do
  task import: :environment do
    ItemImporter.new.run
  end

  task update: :environment do
    ItemUpdater.new.run
  end
end

# frozen_string_literal: true

# rubocop:disable Rails/RakeEnvironment

# tasks for handling common docker ops, mainly for ease of use
namespace :docker do
  desc 'docker tasks to build and store image'
  task :build_and_store do
    desc 'build and store the app image to DockerHub'

    project_json = JSON.parse(File.read(Rails.root.join('lib/tasks/project.json')))
    image_name = "#{project_json['image_name']}:#{project_json['version']}"

    puts 'Checking Docker version...'
    system('docker --version')
    if $CHILD_STATUS.success?
      puts "Docker is installed. Building image #{image_name}"
      system("docker build . -t #{image_name}")

      puts 'Image has been built. Pushing to registry'
      system("docker push #{image_name}")

      puts 'Image pushed to DockerHub successfully'
    else
      puts 'This failed. Please check Docker is installed and the version/ repo name are correct in project.json'
    end
  end

  task :run do
    desc 'Start the local dev set up via Docker Compose'

    puts 'Starting local compose file'
    system('docker compose up -d')
  end

  task :stop do
    desc 'Stop the local dev set up via Docker Compose'

    puts 'Stopping local compose file'
    system('docker compose down')
  end
end

# rubocop:enable Rails/RakeEnvironment

require 'thor'

class Baller
  class CLI < Thor
    class Project < Thor::Group
      include Thor::Actions

      argument :name, required: true, type: :string

      class_option :username, default: `git config --get user.name`.chomp
      class_option :emailaddress, default: `git config --get user.email`.chomp
      class_option :mit, default: true, type: :boolean
      class_option :git, default: true, type: :boolean
      class_option :github, default: true, type: :boolean

      class_option :esp8266, type: :boolean, default: false
      class_option :esp32, type: :boolean, default: true

      class_option :sensors, type: :numeric, default: 1

      class_option :wifi_ssid1, type: :string
      class_option :wifi_ssid2, type: :string
      class_option :wifi_ssid3, type: :string
      class_option :wifi_password1, type: :string
      class_option :wifi_password2, type: :string
      class_option :wifi_password3, type: :string

      def self.source_root
        File.dirname(__FILE__) + '/templates'
      end

      def create_directory
        empty_directory(name)
      end

      def create_subdirectories
        subdirectories = %w[src lib include]
        subdirectories.each do |dir|
          empty_directory("#{name}/#{dir}")
        end
      end

      def top_level
        top_files = %w/README.md platformio.ini/
        top_files.each do |f|
          template("#{f}.tt", "#{name}/#{f}")
        end

        copy_file ".gitignore", "#{name}/.gitignore"
      end

      def src_files
        src_files = %w/main.cpp %name%.h %name%.cpp config.h/
        src_files.each do |f|
          template("src/#{f}.tt", "#{name}/src/#{f}")
        end
      end

      def license
        if options[:mit]
          copy_file 'MIT-LICENSE', "#{name}/MIT-LICENSE"
        end
      end

      def git
        if options[:git]
          Dir.chdir(name)
          `git init`
          `git add .`
        end
      end

      def github
        if options[:github]
          empty_directory "#{name}/.github"
          empty_directory "#{name}/.github/workflows"
          copy_file ".github/workflows/main.yml", "#{name}/.github/workflows/main.yml"
        end
      end
    end
  end
end

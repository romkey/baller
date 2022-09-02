require 'thor'

require 'baller/project'

class Baller
  class CLI < Thor
    register Baller::CLI::Project, "new", "new PATHNAME", "Generate a new Ruby Homebus app named PATHNAME"

    def self.exit_on_failure?
      true
    end
  end
end

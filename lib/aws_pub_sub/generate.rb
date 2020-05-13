module AwsPubSub
  class Generate
    attr_reader :path

    def initialize(path)
      @path = File.expand_path(
        File.join(Dir.pwd, path)
      )
    end

    def run
      copy_templates
      mv_dotfiles
      create_log_dir
    end

    def copy_templates
      FileUtils.mkdir_p(path)
      Dir["#{template_dir}/*"].each{ |f| FileUtils.cp_r(f, path) }
    end

    def mv_dotfiles
      [
        "gitignore",
        "env",
        "env.sample",
        "ruby-version",
        "ruby-gemset"
      ].each do |filename|
        FileUtils.mv("#{path}/#{filename}", "#{path}/.#{filename}")
      end
    end

    def create_log_dir
      FileUtils.mkdir_p("log")
      FileUtils.touch("log/.gitkeep")
    end

    def template_dir
      File.expand_path(File.join(__dir__, "app_template"))
    end
  end
end
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

    def template_dir
      File.expand_path(File.join(__dir__, "app_template"))
    end
  end
end
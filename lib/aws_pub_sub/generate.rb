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
      mv_gitignore
    end

    def copy_templates
      FileUtils.mkdir_p(path)
      Dir["#{template_dir}/*"].each{ |f| FileUtils.cp_r(f, path) }
    end

    def mv_gitignore
      FileUtils.mv("#{path}/gitignore", "#{path}/.gitignore")
    end

    def template_dir
      File.expand_path(File.join(__dir__, "app_template"))
    end
  end
end
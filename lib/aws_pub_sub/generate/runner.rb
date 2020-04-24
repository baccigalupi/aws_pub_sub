module AwsPubSub
  module Generate
    class Runner
      attr_reader :path

      def initialize(path)
        @path = File.expand_path(
          File.join(Dir.pwd, path)
        )
      end

      def run
        copy_template_director
        mv_gitignore
      end

      def copy_templates
        FileUtils.mkdir_p(path)
        FileUtils.cp_r(template_dir, path)
      end

      def mv_gitignore
        FileUtils.mv("#{template_dir}/gitignore", "#{template_dir}/.gitignore")
      end
    end
  end
end
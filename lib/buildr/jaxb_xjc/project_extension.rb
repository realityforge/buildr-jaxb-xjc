module Buildr
  module JaxbXjc
    def compile_jaxb(files, *args)
      options = Hash === args.last ? args.pop.dup : {}
      rake_check_options options, :directory, :keep_content, :package, :id
      args = args.dup
      files = Array === files ? files.flatten : [files]

      target_dir = options[:directory] || path_to(:target, :generated, :jaxb)
      timestamp_file = File.expand_path("#{target_dir}/jaxb-#{options[:id] || 1}.cache")

      file(target_dir => timestamp_file)
      
      file(timestamp_file => files.flatten) do |task|
        rm_rf target_dir unless options[:keep_content]
        mkdir_p target_dir 
        args << "-d" << target_dir
        args << "-p" << options[:package] if options[:package]
        args += files.collect{|f| f.to_s} 
        JaxbXjc.xjc args
        touch timestamp_file
      end

      target_dir
    end
  end

  class Project
    include JaxbXjc
  end
end

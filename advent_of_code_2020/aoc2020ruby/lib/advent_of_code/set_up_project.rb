module AdventOfCode
  class SetUpProject
    def project_details
      JSON.parse(File.read('bin/project_details.json'))
    end

    def gemspec_path
      Dir.glob('*.gemspec').first
    end

    def parse_gemspec
      g = File.readlines(gemspec_path)
    end

    def project_files(_module_str, _spec_str)
      grep_ary = `grep -rnw -e "#{project_details['module']}\\|#{project_details['spec']}"`.split("\n")
      grep_ary.map do |x|
        x.split(':').first unless x.match?('.git')
      end .compact.uniq
    end
  end
end

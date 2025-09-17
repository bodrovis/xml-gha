# frozen_string_literal: true

require 'fileutils'

BASE_DIR = File.join(Dir.pwd, 'g11n', 'data', 'src', 'main', 'res')

REGION_MAP = {
  'es' => '419', # Latin America & Caribbean
  'en' => '001' # World / International English
}.freeze

def rename_dirs!
  unless Dir.exist?(BASE_DIR)
    warn "[skip] base dir not found: #{BASE_DIR}"
    return
  end

  Dir.children(BASE_DIR).each do |entry|
    old_path = File.join(BASE_DIR, entry)
    next unless File.directory?(old_path)

    case entry
    when /\Avalues-b\+([a-zA-Z0-9]{2,8})\z/
      lang = Regexp.last_match(1).downcase
      region = REGION_MAP[lang]

      if region.nil?
        puts "[skip] #{entry} -> region unknown for lang=#{lang}"
        next
      end

      new_name = "values-b+#{lang}+#{region}"
      new_path = File.join(BASE_DIR, new_name)

      if File.exist?(new_path)
        puts "[merge] #{entry} -> #{new_name} (target exists, merging files)"
        FileUtils.mkdir_p(new_path)
        Dir.children(old_path).each do |child|
          src = File.join(old_path, child)
          dst = File.join(new_path, child)
          if File.exist?(dst)
            puts "  [keep] #{child} already exists in #{new_name}, leaving it as is"
          else
            FileUtils.mv(src, dst)
            puts "  [mv] #{child}"
          end
        end
        Dir.rmdir(old_path) if Dir.empty?(old_path)
      else
        puts "[mv] #{entry} -> #{new_name}"
        FileUtils.mv(old_path, new_path)
      end

    when /\Avalues-b\+([a-zA-Z0-9]{2,8})\+[a-zA-Z0-9]+\z/
      puts "[skip] #{entry} (already has region)"
    else
      # puts "[ignore] #{entry}"
      next
    end
  end
end

rename_dirs!

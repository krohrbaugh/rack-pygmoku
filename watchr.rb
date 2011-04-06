def run_spec(file)
  unless File.exist? file
    puts "#{file} does not exist; you're a bad TDDer!"
    return
  end

  puts "Running #{file}"
  system "bundle exec rspec #{file}"
  puts
end

watch ("^spec/.*/*_spec.rb") do |match|
  run_spec match[0]
end

watch("^(lib)/(.*/.*)\.rb") do |match|
  run_spec File.join('spec', match[1], "#{match[2]}_spec.rb")
end

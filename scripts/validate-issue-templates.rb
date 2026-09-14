require 'yaml'

dir = '.github/ISSUE_TEMPLATE'
errors = []
abort "#{dir} is missing" unless Dir.exist?(dir)

Dir.glob("#{dir}/*.{yml,yaml}").sort.each do |path|
  before = errors.size
  begin
    doc = YAML.load_file(path)
  rescue => e
    errors << "#{path}: does not parse (#{e.class}). GitHub ignores templates it cannot parse and silently falls back to blank issues."
    next
  end

  if File.basename(path).start_with?('config.')
    # Routing config, not an issue form.
    if doc['blank_issues_enabled'] != false
      errors << "#{path}: blank_issues_enabled must be false, or the New Issue page offers a blank issue again."
    end
    links = doc['contact_links']
    if !links.is_a?(Array) || links.empty?
      errors << "#{path}: needs at least one contact_link."
    else
      links.each_with_index do |l, i|
        %w[name url about].each do |k|
          errors << "#{path}: contact_links[#{i}] missing #{k}." unless l.is_a?(Hash) && l[k].is_a?(String) && !l[k].strip.empty?
        end
        if l.is_a?(Hash) && l['url'].is_a?(String) && !l['url'].start_with?('https://')
          errors << "#{path}: contact_links[#{i}] url must be https."
        end
      end
    end
    if errors.size == before
      puts "ok  #{path} (#{links.size} contact links, blank issues disabled)"
    else
      puts "FAIL #{path}"
    end
  else
    # Issue form schema.
    %w[name description body].each do |k|
      errors << "#{path}: missing top-level '#{k}'." unless doc.is_a?(Hash) && doc[k]
    end
    body = doc.is_a?(Hash) ? doc['body'] : nil
    if body.is_a?(Array)
      body.each_with_index do |el, i|
        unless el.is_a?(Hash) && el['type']
          errors << "#{path}: body[#{i}] missing 'type'."
          next
        end
        if %w[input textarea dropdown checkboxes].include?(el['type'])
          label = el.dig('attributes', 'label')
          errors << "#{path}: body[#{i}] (#{el['type']}) needs attributes.label." unless label.is_a?(String) && !label.strip.empty?
          errors << "#{path}: body[#{i}] needs an 'id' to be referenced." unless el['id'].is_a?(String) && !el['id'].strip.empty?
        end
      end
      if errors.size == before
        puts "ok  #{path} (#{body.size} form elements)"
      else
        puts "FAIL #{path}"
      end
    else
      errors << "#{path}: 'body' must be a list."
    end
  end
end

if errors.empty?
  puts "\nIssue templates valid."
else
  puts "\n#{errors.size} problem(s):"
  errors.each { |e| puts "  - #{e}" }
  exit 1
end

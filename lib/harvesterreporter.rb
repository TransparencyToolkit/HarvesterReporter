require 'curb'
require 'json'

class HarvesterReporter
  def initialize(cm_hash = nil)
    @cm_url = cm_hash[:crawler_manager_url] if cm_hash
    @selector_id = cm_hash[:selector_id] if cm_hash

    # Output array for when Harvester isn't used
    @output = Array.new
  end

  # Figure out how to report results
  def report_results(results, link)
    if @cm_url
      report_incremental(results, link)
    else
      report_batch(results)
    end
  end

  # Report all results in one JSON
  def report_batch(results)
    results.each do |result|
      @output.push(result)
    end
  end

  # Report results back to Harvester incrementally
  def report_incremental(results, link)
    curl_url = @cm_url+"/relay_results"
    c = Curl::Easy.http_post(curl_url,
                             Curl::PostField.content('selector_id', @selector_id),
                             Curl::PostField.content('status_message', "Collected " + link),
                             Curl::PostField.content('results', JSON.pretty_generate(results)))
  end

  # Output JSON
  def gen_json
    return JSON.pretty_generate(@output)
  end
end

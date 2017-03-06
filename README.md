This handles reporting results back to Harvester from individual
scrapers. When not using Harvester, it also handles saving the results and
generating a JSON of the results.

To install-
gem install harvesterreporter


To use-

1. Create a hash with the following information about Harvester-
   * crawler_manager_url: The URL of the Harvester instance
   * selector_id: The corresponding selector on Harvester (if any)
If no hash is provided, results will be saved in an array and output as JSON
at the end of the crawler's run.

2. reporter = HarvesterReporter.new(cm_hash)

3. To report the results-
reporter.report_results([result, array], "link or other status message")

4. It should report the results on its own, but if you are not using
Harvester, you should call reporter.gen_json to get the JSON output.
